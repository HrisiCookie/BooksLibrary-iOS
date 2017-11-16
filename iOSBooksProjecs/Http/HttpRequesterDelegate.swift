//
//  HttpRequesterDelegate.swift
//  iOSBooksProjecs
//
//  Created by Cookie on 4/3/17.
//  Copyright © 2017 Cookie. All rights reserved.
//

import UIKit

protocol HttpRequesterDelegate {
    func didReceiveData(data: Any)
    func didReceiveError(error: Error)
}

extension HttpRequesterDelegate {
    func didReceiveData(data: Any) {
    }
    func didReceiveError(error: Error) {
    }
}
