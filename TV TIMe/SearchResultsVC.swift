//
//  SearchResultsVC.swift
//  TV TIMe
//
//  Created by Tim Beemsterboer on 3/14/18.
//  Copyright © 2018 Tim Beemsterboer. All rights reserved.
//

import UIKit

class SearchResultsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tvShows: [TVShow] = []
    var showsList: [TVShow] = []
    var detailList: [TVShow] = []
    var name = ""
    @IBOutlet weak var showsTableView: UITableView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "protoCell", for: indexPath)
        myCell.textLabel?.text = showsList[indexPath.row].name
        return myCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you chose a show \(indexPath.row)")
        detailList.append(showsList[indexPath.row])
        self.performSegue(withIdentifier: "detailSegue", sender: nil)
    }
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        showsTableView.delegate = self
        showsTableView.dataSource = self
        
        for show in showsList {
            print("\(show.name) \(show.genres)" )
            
        }
        print("this is from the 2nd page")
        print(showsList.count)
        print(tvShows.count)
        nameLabel.text = "Shows that match \(name)"
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
           
            guard let DetailViewVC = segue.destination as? DetailViewVC else {return}
            DetailViewVC.showDetail = self.detailList
            DetailViewVC.tvShows = self.tvShows
        }
    }
    @IBAction func didUnwindFromDetailViewVC (_ sender: UIStoryboardSegue) {
        detailList = []
    
    }
}
