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
}

}
