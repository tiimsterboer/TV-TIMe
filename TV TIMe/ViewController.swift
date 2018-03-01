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
    
    var tvShows = [TVShow]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func getData(_ sender: Any) {
        saveShows()
        }
    
    @IBAction func showData(_ sender: Any) {
        
        if let savedShows = loadShows(){
            tvShows += savedShows
        }
        for show in tvShows {
            print (show.name)
            
        }
        print(tvShows.count)
    }
    
    
    func saveShows() {
        print("action works")
        
        
        
        let page = 1
        let webpage = "https://api.tvmaze.com/shows?page=\(page)"
        let url: NSURL = NSURL(string: webpage)!
        
        /*Alamofire.request("https://api.tvmaze.com/shows?page=0").responseJSON { (responseData) -> Void in
         if((responseData.result.value) != nil) {
         let swiftyJsonVar = JSON(responseData.result.value!)
         //print(swiftyJsonVar)
         for item in swiftyJsonVar.array! {
         let show = TVShow(*/
        
        /*print(item["name"].stringValue)
         print(item["genres"].arrayValue)
         print(Int32(item["id"].intValue))
         print(item["type"].stringValue)
         print(item["language"].stringValue)
         print(item["summary"].stringValue)*/
        
        
        /*URLSession.shared.dataTask(with: url!) { (data, response, error) in
         
         if error != nil {
         print("There was an issue")
         print(error)
         } else {
         
         print("got to here")
         do {
         print("Json work")
         
         self.json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: AnyObject]
         let myData = self.json["data"]!*/
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
            print(tvShows[45].name)
            print(tvShows[226].genres)
            print(tvShows[137].summary)
        }
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(tvShows, toFile: TVShow.ArchiveURL.path)
        
        if isSuccessfulSave {
            os_log("Show saved", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed", log: OSLog.default, type: .error)
        }
    }
    
    private func loadShows() -> [TVShow]? {
        
        return NSKeyedUnarchiver.unarchiveObject(withFile: TVShow.ArchiveURL.path) as? [TVShow]!
        
    }
    
    }
    



