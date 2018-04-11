//
//  ViewController.swift
//  TV TIMe
//
//  Created by Tim Beemsterboer on 2/26/18.
//  Copyright © 2018 Tim Beemsterboer. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import os.log

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    var tvShows: [TVShow] = []
    var searchShows: [TVShow] = []
    var userQueue: [TVShow] = []
    var myName = "Tim"
    var n = Int(arc4random_uniform(20367))
    var activityIndicator = UIActivityIndicatorView()
    

    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var loadingLbl: UILabel!
    
    @IBOutlet weak var queueTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        queueTableView.delegate = self
        queueTableView.dataSource = self
        
        
        
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = .gray
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        // Do any additional setup after loading the view, typically from a nib.
        DispatchQueue.global(qos:.userInteractive).async {
            if let savedShows = self.loadShows(){
                self.tvShows += savedShows
                print("shows loaded")
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.loadingLbl.isHidden = true
                    UIApplication.shared.endIgnoringInteractionEvents()
                    print(self.tvShows.count)
                    self.searchField.becomeFirstResponder()
                    self.userQueue.append(self.tvShows[self.n])
                    print(self.userQueue[0].name)
                }
                    
            }
        }
     
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userQueue.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = userQueue[indexPath.row].name
        
        return cell
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        queueTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func getData(_ sender: Any) {
        saveShows()
        }
    
    @IBAction func showData(_ sender: Any) {
        
        for show in tvShows {
            print (show.name)
            
        }
        print(tvShows.count)
    }
    
    @IBAction func search(_ sender: Any) {
        
        print("search pressed")
        
        
    }
    @IBAction func clear(_ sender: Any) {
        tvShows = []
    }
    private func searchTheShows() {
        searchShows = []
        print("works")
        print(searchField.text!)
        //var searchText = "Chicago"
        for show in tvShows {
            if show.name.contains(searchField.text!) {
                searchShows.append(show)
                //print(show.name)
                //print(show.imageURL ?? "default URL")
            }
            
        }
        print(searchShows.count)
        
    }
    private func saveShows() {
        print("action works")
        
        
        
        for page in 0...139 {
            let webpage = "https://api.tvmaze.com/shows?page=\(page)"
            let url: NSURL = NSURL(string: webpage)!
            
            
            do {
                let data: Data = try! Data(contentsOf: url as URL)
                let jsonArray = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSMutableArray
                
                for jsonObject in jsonArray! {
                    if let show = TVShow(json: (jsonObject as AnyObject) as! [String : Any]) {
                        if show.language == "English" {
                            tvShows.append(show)
                        }
                        
                    }
                    if tvShows.count == 0 {
                        print("no shows parsed")
                    }
                    
                }
                print(tvShows.count)
                //print(tvShows[45].name)
               //print(tvShows[226].genres)
                //print(tvShows[137].summary)
            }
        
            let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(tvShows, toFile: TVShow.ArchiveURL.path)
            
            if isSuccessfulSave {
                os_log("Show saved", log: OSLog.default, type: .debug)
            } else {
                os_log("Failed", log: OSLog.default, type: .error)
            }
        }
    }
    
    private func loadShows() -> [TVShow]? {
        
        return NSKeyedUnarchiver.unarchiveObject(withFile: TVShow.ArchiveURL.path) as? [TVShow]!
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchSegue" {
            searchTheShows()
            guard let SearchResultsVC = segue.destination as? SearchResultsVC else {return}
            SearchResultsVC.showsList = self.searchShows
            SearchResultsVC.name = self.searchField.text!
            SearchResultsVC.tvShows = self.tvShows
            print(searchShows.count)
            print(SearchResultsVC.showsList.count)
        }
    }
    @IBAction func didUnwindFromSearchResultsVC(_ sender: UIStoryboardSegue) {
        guard let SearchResultsVC = sender.source as? SearchResultsVC else { return }
        
        }
    
    }
    



