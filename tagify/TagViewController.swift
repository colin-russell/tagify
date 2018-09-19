//
//  TagViewController.swift
//  tagify
//
//  Created by Colin on 2018-09-18.
//  Copyright © 2018 Colin Russell. All rights reserved.
//

import UIKit

class TagViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Properties
    
    @IBOutlet weak var tagTableView: UITableView!
    var tags = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tagTableView.isHidden = true
        
        let spinner = UIActivityIndicatorView(style: .gray)
        spinner.center = self.view.center
        view.addSubview(spinner)
        spinner.startAnimating()
        
        let networkManager = NetworkManager()
        networkManager.fetchAllTags { (tags) in
                self.tags = tags
                self.tagTableView.reloadData()
                
                spinner.stopAnimating()
                self.tagTableView.isHidden = false
        }
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tags.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tagCell", for: indexPath)
        cell.textLabel?.text = tags[indexPath.row]
        
        return cell
    }

}
