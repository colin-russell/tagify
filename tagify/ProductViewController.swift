//
//  ProductViewController.swift
//  tagify
//
//  Created by Colin on 2018-09-19.
//  Copyright © 2018 Colin Russell. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {
    
    var tag = String()
    var products = [Product]()
    var foundProducts = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        findProductsWithTag(tag: tag)
    }
    
    func findProductsWithTag(tag: String) {
        for product in products {
            if product.tags.contains(tag) {
                foundProducts.append(product)
            }
        }
        print("foundProducts: \(foundProducts)")
    }
}
