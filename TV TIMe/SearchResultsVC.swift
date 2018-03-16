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
    var name = ""
    
    @IBOutlet weak var nameLabel: UILabel!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "protoCell", for: indexPath)
        myCell.textLabel?.text = "TVSHOW"
        return myCell
    }
    
    override func viewDidLoad() {
        super .viewDidLoad()
        for show in showsList {
            print("\(show.name) \(show.genres)" )
            
        }
        print("this is from the 2nd page")
        print(showsList.count)
        nameLabel.text = "Shows that match \(name)"
    }
    
}
