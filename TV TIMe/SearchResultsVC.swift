//
//  SearchResultsVC.swift
//  TV TIMe
//
//  Created by Tim Beemsterboer on 3/14/18.
//  Copyright © 2018 Tim Beemsterboer. All rights reserved.
//

import UIKit

class SearchResultsVC: UIViewController, UITableViewDataSource {
    
    var showsList: [TVShow] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = UITableViewCell()
        myCell.textLabel?.text = "TVSHOW"
        return myCell
    }
    
    override func viewDidLoad() {
        super .viewDidLoad()
        for show in showsList {
            print(show.language)
            
        }
        print("this is from the 2nd page")
    }
    
}
