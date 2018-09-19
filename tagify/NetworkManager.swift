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
                guard let results = try! JSONSerialization.jsonObject(with: data!, options: []) as? [String : [[String : Any]]] else {
                    print("Invalid JSON")
                    completion([""])
                    return
                }
                
                guard let products = results["products"] else { return }
                
                var tagSet = Set<String>()
                
                for product in products {
                    guard let tagString = product["tags"] as? String else { return }
                    
                    let tagArray = tagString.split(separator: ",")
                    
                    for element in tagArray {
                        tagSet.insert(element.trimmingCharacters(in: NSCharacterSet.whitespaces))
                    }
                }
                
                completion(tagSet.sorted())
            }
        }
        
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
    func fetchAllProducts(completion: @escaping (_ tags: [Product]) -> Void) {
        guard let url = URL(string: "https://shopicruit.myshopify.com/admin/products.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if (error == nil) { print("URL session success") }
            else { print("URL session failure: \(error!.localizedDescription)") }
            
            DispatchQueue.main.async {
                guard let results = try! JSONSerialization.jsonObject(with: data!, options: []) as? [String : [[String : Any]]] else {
                    print("Invalid JSON")
                    completion([Product]())
                    return
                }
                
                guard let productsJSON = results["products"] else { return }
                
                var productArray = [Product]()
                
                for element in productsJSON {
                    guard let name = element["title"] as? String else { return }
                    guard let variants = element["variants"] as? Array<Dictionary<String, Any>> else { return }
                    var quantity = Int()
                    
                    for variant in variants {
                        guard let num = variant["inventory_quantity"] as? Int else { return }
                        quantity += num
                    }
                    
                    productArray.append(Product(name: name, quantity: quantity))
                }
                
                completion([Product]())
            }
        }
        
        task.resume()
        session.finishTasksAndInvalidate()
    }
}
