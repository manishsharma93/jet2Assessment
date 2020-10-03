//  Webservices.swift
//  Jet2Assessment
//
//  Created by Manish Kumar on 30/09/20.
//  Copyright © 2020 Manish Kumar. All rights reserved.
//

import Foundation

class Webservices: NSObject {
    
    func callGetService(methodName: String, params: [String:Any], successBlock:@escaping (_ response:Data)->Void, errorBlock:@escaping (_ error:Any)->Void) {
                
        let urlString = "\(WebServiceMethods.WS_BASE_URL)\(methodName)"

        var request = URLRequest(url: URL(string: "\(urlString)")!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in
            do {
                if !(error != nil) {
                    successBlock(data ?? Data())
                } else {
                    print("error")
                    errorBlock(error?.localizedDescription ?? "")
                }
            }
        })

        task.resume()
    }
    
    func appendParametersToURL(urlStr: String, params: [String:Any]) -> String {
        var urlString = urlStr
        if params.count > 0 {
            var i = 0;
            let keysArray = params.keys
            for key in keysArray {
                if i == 0 {
                    urlString.append("?\(key)=\(params[key] ?? "")")
                } else {
                    urlString.append("&\(key)=\(params[key] ?? "")")
                }
                i += 1
            }
        }
        
        return urlString
    }
    
}
