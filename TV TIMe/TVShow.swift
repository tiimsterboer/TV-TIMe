//
//  TVShow.swift
//  TV TIMe
//
//  Created by Tim Beemsterboer on 2/26/18.
//  Copyright © 2018 Tim Beemsterboer. All rights reserved.
//

import Foundation
import os.log

class TVShow: NSObject, NSCoding {
    
    //properties
    var id: Int32
    var name: String
    var type: String
    var language: String
    var summary: String
    var genres: [String]
    
    //Types
    struct PropertyKey {
        static let id = "id"
        static let name = "name"
        static let type = "type"
        static let language = "language"
        static let summary = "summary"
        static let genres = "genres"
    }
    
    //Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("shows")
    
    //initializer
    init?(json: [String: Any]) {
        guard
            let id = json["id"] as? Int32,
            let name = json["name"] as? String
            else {
                return nil
        }
        self.id = id
        self.name = name
        self.type = json["type"] as? String ?? "default type"
        self.language = json["language"] as? String ?? "default language"
        self.summary = json["summary"] as? String ?? "default summary"
        self.genres = json["genres"] as? [String] ?? ["default genre"]
    }
    
    //Initialization
   init?(id: Int32, name: String, type: String, language: String, summary: String, genres: [String]) {
        self.id = id
        self.name = name
        self.type = type
        self.language = language
        self.summary = summary
        self.genres = genres
        super.init()
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: PropertyKey.id)
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(type, forKey: PropertyKey.type)
        aCoder.encode(language, forKey: PropertyKey.language)
        aCoder.encode(summary, forKey: PropertyKey.summary)
        aCoder.encode(genres, forKey: PropertyKey.genres)
    }
    
    required convenience init(coder aDecoder: NSCoder){
        let id = aDecoder.decodeInt32(forKey: PropertyKey.id)
        let name = aDecoder.decodeObject(forKey: PropertyKey.name) as! String
        let type = aDecoder.decodeObject(forKey: PropertyKey.type) as! String
        let language = aDecoder.decodeObject(forKey: PropertyKey.language) as! String
        let summary = aDecoder.decodeObject(forKey: PropertyKey.summary) as! String
        let genres = aDecoder.decodeObject(forKey: PropertyKey.genres) as! Array<String>
        
        self.init(id: id, name: name, type: type, language: language, summary: summary, genres: genres)!
        
        
    }
}
