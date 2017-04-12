//
//  BookDictionary.swift
//  iOSBooksProjecs
//
//  Created by Cookie on 4/3/17.
//  Copyright © 2017 Cookie. All rights reserved.
//

import Foundation

extension Book {
    convenience init(withDict dict: Dictionary<String, Any>) {
        let id = dict["_id"] as! String
        let title = dict["title"] as! String
        let bookDescription = dict["description"] as? String ?? ""
        let coverUrl = dict["coverUrl"] as? String ?? ""
        self.init(withId: id, title: title, bookDescription: bookDescription, andCoverUrl: coverUrl)
    }
    
    func toDict() -> Dictionary<String, Any> {
        return [
            "title": self.title!,
            "description": self.bookDescription!,
            "coverUrl": self.coverUrl
        ]
    }
}
