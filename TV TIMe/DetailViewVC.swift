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
    
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var showImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        detailLabel.text = showDetail[0].summary
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
        var topMatches = Dictionary<String, Double>()
        for x in 0...5 {
            let cos = CosSim.cosSim(wordBag: CosSim.wordCount(r: showDetail[0].summary, s: tvShows[x].summary).wordBag, freq1: CosSim.wordCount(r: showDetail[0].summary, s: tvShows[x].summary).freq1, freq2: CosSim.wordCount(r: showDetail[0].summary, s: tvShows[x].summary).freq2)
            topMatches.updateValue(cos, forKey: tvShows[x].name)
            
            }
        print(topMatches)
    }
    
            
}
    


