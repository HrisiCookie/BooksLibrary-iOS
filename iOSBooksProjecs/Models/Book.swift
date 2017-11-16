//
//  Books.swift
//  iOSBooksProjecs
//
//  Created by Cookie on 4/2/17.
//  Copyright © 2017 Cookie. All rights reserved.
//

import UIKit

class Book {
    var id: String?
    var title: String?
    var bookDescription: String?
    
    var image: UIImage?
    
    var coverUrl: String
    
    convenience init(withTitle title: String,
         bookDescription: String,
         andCoverUrl coverUrl: String) {
        self.init(withId: "",
            title: title,
            bookDescription: bookDescription,
            andCoverUrl: coverUrl)
    }
    init(withId id: String,
         title: String,
         bookDescription: String,
         andCoverUrl coverUrl: String) {
        self.id = id
        self.title = title
        self.bookDescription = bookDescription
        self.coverUrl = coverUrl
        }
}
