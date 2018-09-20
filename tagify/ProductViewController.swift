//
//  ProductViewController.swift
//  tagify
//
//  Created by Colin on 2018-09-19.
//  Copyright © 2018 Colin Russell. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Properties
    
    @IBOutlet weak var productTableView: UITableView!
    var tag = String()
    var products = [Product]()
    var foundProducts = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        findProductsWithTag(tag: tag)
    }
    
    /*
     Only finds the products with the selected tag
    */
    func findProductsWithTag(tag: String) {
        for product in products {
            if product.tags.contains(tag) {
                foundProducts.append(product)
            }
        }
        productTableView.reloadData()
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foundProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath)
        cell.textLabel?.text = "\(foundProducts[indexPath.row].name) | Quantity: \(foundProducts[indexPath.row].quantity)"
        cell.textLabel?.font = UIFont(name: cell.textLabel!.font.fontName, size: 12)
        cell.imageView?.image = foundProducts[indexPath.row].image
        return cell
    }
}
