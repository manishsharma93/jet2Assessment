//
//  ArticlesViewController.swift
//  Jet2Assessment
//
//  Created by Manish Kumar on 30/09/20.
//  Copyright © 2020 Manish Kumar. All rights reserved.
//

import UIKit

class ArticlesViewController: UIViewController {
    
    @IBOutlet weak var articleListingTableView: UITableView!
    
    let reachability = Reachability()!
    
    var articleResponse: [ArticleResponse]?

    var currentPage: Int = 1

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //UITableview setup
        articleListingTableView.rowHeight = UITableView.automaticDimension
        articleListingTableView.estimatedRowHeight = 180
        articleListingTableView.tableFooterView = UIView()
        
        articleListingTableView.tableFooterView = UIView()
        
        //Registering TableView cells
        registerCells()
        
        //Fetching list of articles
        fetchArticleData(page_number: currentPage)
        
    }
    
    func registerCells() {
        articleListingTableView.register(UINib(nibName: "ArticleTableViewCell", bundle: nil), forCellReuseIdentifier: "ArticleTableViewCell")
    }
    
    func fetchArticleData(page_number: Int) {
        
        if reachability.currentReachabilityStatus == .notReachable {
            //Fetch data if there is no internet connection
            DispatchQueue.main.async {
                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
                let context = appDelegate.persistentContainer.viewContext
                
                self.articleResponse = Jet2Preferences().fetchData(context: context)
                
                if self.articleResponse?.count == 0 {
                    print("No data found!!")
                }
            }
            return
        }
        
        let params = [
            "page" : page_number,
            "limit" : 10
            ] as [String : Any]
        
        //Web service call for fetching list of movies
        Webservices().callGetService(methodName: WebServiceMethods.WS_GET_ARTICLE, params: params, successBlock: { (data) in
            do {
                let jsonDecoder = JSONDecoder()
                //Parsing data
                let responseData = try jsonDecoder.decode([ArticleResponse].self, from: data)
                
                //Checking and appending data to the movies data array
                self.articleResponse = self.articleResponse?.count == 0 ? responseData : (self.articleResponse ?? []) + (responseData)
                                
                //save data in CoreData
                DispatchQueue.main.async {
                    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
                    let context = appDelegate.persistentContainer.viewContext
                    Jet2Preferences().saveData(articleData: self.articleResponse ?? [], context: context)
                }
                
                DispatchQueue.main.async {
                    self.articleListingTableView.reloadData()
                }
            } catch {
                
            }
        }) { (error) in
            
        }
    }

}

extension ArticlesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleResponse?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as! ArticleTableViewCell
        
        let articleData = articleResponse?[indexPath.row]

        cell.userImageView.loadImage(articleData?.user?.first?.avatar ?? "")
        
        cell.lblUserName.text = (articleData?.user?.first?.name ?? "") + (articleData?.user?.first?.lastname ?? "")
        cell.lblUserDesignation.text = articleData?.user?.first?.designation ?? ""
        
        cell.lblArticleDuration.text = articleData?.createdAt ?? ""
        
        if articleData?.media?.first?.image != nil && articleData?.media?.first?.image != "" {
            cell.articleImageView.loadImage(articleData?.media?.first?.image ?? "")
            cell.articleImageVIewHeightConstraint.constant = 120
        } else {
            cell.articleImageVIewHeightConstraint.constant = 0
        }
        
        cell.lblArticleContent.text = articleData?.content ?? ""
        cell.lblArticleTitle.text = articleData?.media?.first?.title ?? ""
        cell.btnArticleUrl.setTitle(articleData?.media?.first?.url ?? "", for: .normal)
        cell.btnArticleUrl.tag = indexPath.row

        cell.lblLikes.text = "\(articleData?.likes ?? 0) Likes"
        cell.lblComments.text = "\(articleData?.comments ?? 0) Comments"

        return cell
        
    }
}

// MARK:- UIScrollView Delegates
extension ArticlesViewController: UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        // UITableView only moves in one direction, y axis
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        
        // Change 10.0 to adjust the distance from bottom
        if maximumOffset - currentOffset <= 10.0 {
            currentPage = currentPage + 1
            fetchArticleData(page_number: currentPage)
        }
    }
}
