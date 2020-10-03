//
//  Jet2Preferences.swift
//  Jet2Assessment
//
//  Created by Manish Kumar on 03/10/20.
//  Copyright © 2020 Manish Kumar. All rights reserved.
//

import UIKit
import CoreData

class Jet2Preferences: NSObject {

    func saveData(articleData: [ArticleResponse], context:NSManagedObjectContext) {
        
        var newArticle: ArticleResponse? = nil
        
        for article in articleData {
            
            newArticle?.id = article.id
            newArticle?.createdAt = article.createdAt
            newArticle?.content = article.content
            newArticle?.comments = article.comments
            newArticle?.likes = article.likes
            newArticle?.media = article.media
            newArticle?.user = article.user
        }

        let _ : NSError? = nil
        do {
            try context.save()
        } catch {
            print("Storing data Failed : \(error.localizedDescription )")
        }
    }
    
    func fetchData(context:NSManagedObjectContext) -> [ArticleResponse] {
        var resultData = [ArticleResponse]()
        
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ArticleData")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [ArticleResponse] {
                resultData.append(data)
            }
        } catch {
            print("Fetching data Failed")
        }
        
        return resultData
    }
}
