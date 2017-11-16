//
//  User.swift
//  iOSBooksProjecs
//
//  Created by Cookie on 4/3/17.
//  Copyright © 2017 Cookie. All rights reserved.
//

import UIKit

class User: NSObject {
    var username: String
    var passHash: String
    
    init(username username: String, passHash passHash: String) {
        self.username = username
        self.passHash = passHash
    }
    
    convenience init(withDict dict: Dictionary<String, Any>) {
        let username = dict["username"] as! String
        let passHash = dict["passHash"] as! String
        self.init(username: username, passHash: passHash)
    }
    
    func toDict() -> Dictionary<String, Any> {
        return [
            "username": self.username,
            "passHash": self.passHash,
        ]
    }

}
