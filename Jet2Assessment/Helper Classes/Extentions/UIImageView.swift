//
//  UIImageView.swift
//  Jet2Assessment
//
//  Created by Manish Kumar on 30/09/20.
//  Copyright © 2020 Manish Kumar. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func loadImage(_ URLString: String) {
        let imageCache = NSCache<NSString, UIImage>()

        self.image = nil
        //If imageurl's imagename has space then this line going to work for this
        let imageServerUrl = URLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        if let cachedImage = imageCache.object(forKey: NSString(string: imageServerUrl)) {
            self.image = cachedImage
            return
        }
        
        if let url = URL(string: imageServerUrl) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                
                //print("RESPONSE FROM API: \(response)")
                if error != nil {
                    print("ERROR LOADING IMAGES FROM URL: \(error ?? "" as! Error)")
                    DispatchQueue.main.async {
                        self.image = UIImage(named: "placeholder")
                    }
                    return
                }
                DispatchQueue.main.async {
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            imageCache.setObject(downloadedImage, forKey: NSString(string: imageServerUrl))
                            self.image = downloadedImage
                        }
                    }
                }
            }).resume()
        }
    }
    
}
