//
//  ArticleTableViewCell.swift
//  Jet2Assessment
//
//  Created by Manish Kumar on 02/10/20.
//  Copyright © 2020 Manish Kumar. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblUserDesignation: UILabel!
    @IBOutlet weak var lblArticleDuration: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var articleImageVIewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var lblArticleContent: UILabel!
    @IBOutlet weak var lblArticleTitle: UILabel!
    @IBOutlet weak var btnArticleUrl: UIButton!
    @IBOutlet weak var lblLikes: UILabel!
    @IBOutlet weak var lblComments: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        userImageView.layer.cornerRadius = userImageView.frame.width / 2
        userImageView.layer.masksToBounds = true
        userImageView.layer.borderColor = UIColor.lightGray.cgColor
        userImageView.layer.borderWidth = 1.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
