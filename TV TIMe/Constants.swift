//
//  Constants.swift
//  TV TIMe
//
//  Created by Tim Beemsterboer on 4/9/18.
//  Copyright © 2018 Tim Beemsterboer. All rights reserved.
//

import Foundation

var userQueue : [TVShow]?

func saveData( userQueue: [TVShow]) {
    UserDefaults.standard.set(userQueue, forKey: "userQueue")
}

func fetchData() -> [TVShow]? {
    if let queue = UserDefaults.standard.array(forKey: "userQueue") as? [TVShow] {
        return queue
    }
    else {
        return nil
    }
}
