
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
    var selectedTag = String()
    var products = [Product]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tagTableView.isHidden = true

        let spinner = UIActivityIndicatorView(style: .whiteLarge)
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
        networkManager.fetchAllProducts { (products) in
            self.products = products
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pvc = segue.destination as? ProductViewController {
            pvc.tag = selectedTag
            pvc.products = products
        }
    }

    // MARK: UITableViewDelegate

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tags.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tagCell", for: indexPath)
        cell.textLabel?.text = tags[indexPath.row]
        cell.textLabel?.font = UIFont(name: "Arial Rounded MT Bold", size: 16)
        cell.textLabel?.textAlignment = .center
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath)
        guard let cellText = currentCell?.textLabel?.text else { return }
        selectedTag = cellText
        performSegue(withIdentifier:"forward", sender: self)
    }

}
