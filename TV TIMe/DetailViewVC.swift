//
//  DetailViewVC.swift
//  TV TIMe
//
//  Created by Tim Beemsterboer on 3/16/18.
//  Copyright © 2018 Tim Beemsterboer. All rights reserved.
//

import Foundation
import UIKit

class DetailViewVC: UIViewController {
    
    var showDetail : [TVShow] = []
    var tvShows : [TVShow] = []
    
    @IBOutlet weak var resultsLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var showImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let showSumm = showDetail[0].summary.removeTags(txt: showDetail[0].summary)
        detailLabel.text = showSumm
        nameLbl.text = showDetail[0].name
        //genresLbl.text = showDetail[0].genres
        do {
            let data = try Data(contentsOf: showDetail[0].imageURL!)
            self.showImg.image = UIImage(data: data)
        }
        catch let err {
                print("error : \(err.localizedDescription)")
        }
        //print(tvShows.count)
    }
    
    @IBAction func findSimShows(_ sender: Any) {
        //var topMatches = Dictionary<String, Double>()
        var sim = [0.0, 0.0, 0.0]
        var tS = ["", "", ""]
        for x in 0...100 {
            let cos = CosSim.cosSim(wordBag: CosSim.wordCount(r: showDetail[0].summary, s: tvShows[x].summary).wordBag, freq1: CosSim.wordCount(r: showDetail[0].summary, s: tvShows[x].summary).freq1, freq2: CosSim.wordCount(r: showDetail[0].summary, s: tvShows[x].summary).freq2)
            if cos > sim[0] {
                sim[2] = sim[1]
                tS[2] = tS[1]
                sim[1] = sim[0]
                tS[1] = tS[0]
                sim[0] = cos
                tS[0] = tvShows[x].name
            }
            else if cos > sim[1] {
                sim[2] = sim[1]
                tS[2] = tS[1]
                sim[1] = cos
                tS[1] = tvShows[x].name
            }
            else if cos > sim[2] {
                sim[2] = cos
                tS[2] = tvShows[x].name
            }
            //topMatches.updateValue(cos, forKey: tvShows[x].name)
            //similarities.append(cos)
            //print(cos)
            }
        print(sim)
        print(tS)
        
        resultsLbl.isHidden = false
        for show in tS {
            resultsLbl.text = show
        }
        
        /*var topMatches = ["a":0.0, "b":0.0]
        
        for name in topMatches.keys {
            for x in 0...tvShows.count {
                let cos = CosSim.cosSim(wordBag: CosSim.wordCount(r: showDetail[0].summary, s: tvShows[x].summary).wordBag, freq1: CosSim.wordCount(r: showDetail[0].summary, s: tvShows[x].summary).freq1, freq2: CosSim.wordCount(r: showDetail[0].summary, s: tvShows[x].summary).freq2)
                if cos > topMatches[name]! {
                    topMatches.updateValue(cos, forKey: tvShows[x].name)
                    break
                }
            }
        }
        print(topMatches)*/
    }
    
            
}
    


