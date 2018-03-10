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

class ViewController: UIViewController {
    
    var tvShows: [TVShow] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let savedShows = loadShows(){
            tvShows += savedShows
        }
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
        print("works")
        var searchText = "Chicago"
        for show in tvShows {
            if show.name.contains(searchText) {
                print(show.name)
            }
        }
        
        
        
    }
    @IBAction func clear(_ sender: Any) {
        tvShows = []
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
                        tvShows.append(show)
                        
                        
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
    
    }
    



