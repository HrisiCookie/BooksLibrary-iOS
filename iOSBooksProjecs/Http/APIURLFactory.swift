//
//  APIURLFactory.swift
//  iOSBooksProjecs
//
//  Created by Mac User on 5/5/17.
//  Copyright © 2017 Cookie. All rights reserved.
//

import Foundation

struct APIURLFactorty {

    let baseURLString = "http://cookiebookslibrary.herokuapp.com/api"

    func allBooksURL() -> URL? {
        let urlString = "\(baseURLString)/books"
        let encodedUrlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        var allBooksUrl: URL? = nil
        if let encodedUrlString = encodedUrlString {
            allBooksUrl = URL(string: encodedUrlString)
        }
        return allBooksUrl
    }
    
    func singleBookURL(forBookId bookId: String) -> URL? {
        let allBooksUrl = allBooksURL()
        if let allBooksUrl = allBooksUrl {
            let urlString = "\(allBooksUrl)/\(bookId)"
            print(urlString)
            let encodedUrlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            var singleBookUrl: URL? = nil
            if let encodedUrlString = encodedUrlString {
                singleBookUrl = URL(string: encodedUrlString)
            }
            return singleBookUrl
        } else {
            return nil
        }
    }
    
    func loadMoreBooks(pageIndex: Int) -> URL? {
        let allBooksUrl = allBooksURL()
        if let allBooksUrl = allBooksUrl {
            let urlString = "\(allBooksUrl)?page=\(pageIndex)"
            print(urlString)
            let encodedUrlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            var loadMoreBooksUrl: URL? = nil
            if let encodedUrlString = encodedUrlString {
                loadMoreBooksUrl = URL(string: encodedUrlString)
            }
            return loadMoreBooksUrl
        } else {
            return nil
        }
    }
}
