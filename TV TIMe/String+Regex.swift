//
//  String+Regex.swift
//  TV TIMe
//
//  Created by Tim Beemsterboer on 4/9/18.
//  Copyright © 2018 Tim Beemsterboer. All rights reserved.
//

import Foundation

extension String {
    
    
    static var tags2 = ["<p>", "</p>", "<i>", "</i>", "<b>", "</b>"]
    
    func removeTags (txt: String) -> String {
        var txt1 = txt.replacingOccurrences(of: "<", with: " <")
        txt1 = txt1.replacingOccurrences(of: ">", with: "> ")
        let txtArray1 = txt1.components(separatedBy: " ")
        txt1 = txtArray1.filter({ String.tags2.contains($0) == false }).joined(separator:" ")
        
        
        
        return txt1
        
    }
    
}
