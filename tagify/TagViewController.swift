//
//  TagViewController.swift
//  tagify
//
//  Created by Colin on 2018-09-18.
//  Copyright © 2018 Colin Russell. All rights reserved.
//

import UIKit

class TagViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let networkManager = NetworkManager()
        networkManager.fetchAllTags { (tags) in
            print("\(tags)")
        }
        // Do any additional setup after loading the view.
    }
    


}
