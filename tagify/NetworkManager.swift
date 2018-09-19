//
//  NetworkManager.swift
//  tagify
//
//  Created by Colin on 2018-09-18.
//  Copyright © 2018 Colin Russell. All rights reserved.
//

import UIKit

class NetworkManager: NSObject {
    
    func fetchAllTags(completion: @escaping (_ tags: [String]) -> Void) {
        guard let url = URL(string: "https://shopicruit.myshopify.com/admin/products.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if (error == nil) { print("URL session success") }
            else { print("URL session failure: \(error!.localizedDescription)") }
            
            DispatchQueue.main.async {
//                guard let results = try! JSONSerialization.jsonObject(with: data!, options: []) as? [[String : Any]] else {
//                    print("Invalid JSON")
//                    completion([""])
//                    return
//                }
                
                print("results: \(data!.base64EncodedString())")
                completion(["done"])
            }
        }
        
        task.resume()
        session.finishTasksAndInvalidate()
    }
}
