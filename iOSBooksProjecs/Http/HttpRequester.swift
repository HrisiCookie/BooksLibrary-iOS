//
//  HttpRequester.swift
//  iOSBooksProjecs
//
//  Created by Cookie on 4/3/17.
//  Copyright © 2017 Cookie. All rights reserved.
//

import UIKit

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}


class HttpRequester {
    
    var delegate: HttpRequesterDelegate?

    func send(withMethod method: HttpMethod, toUrl urlString: String, withBody bodyDict: Dictionary<String, Any>? = nil,
              andHeaders headers: Dictionary<String, String> = [:]) {
        let url = URL(string: urlString)
        
        var request = URLRequest(url: url!)
        request.httpMethod = method.rawValue
        if (bodyDict != nil) {
            do {
                let body = try JSONSerialization.data(withJSONObject: bodyDict!, options: .prettyPrinted)
                request.httpBody = body
            } catch {
            }
        }
        
        headers.forEach() {request.setValue($0.value, forHTTPHeaderField: $0.key)}
        
        weak var weakSelf = self
        
        let dataTask = URLSession.shared.dataTask(with: request, completionHandler:
            {bodyData, response, error in
                do {
                    let body = try JSONSerialization.jsonObject(with: bodyData!, options: .allowFragments)
                    weakSelf?.delegate?.didReceiveData(data: body)
                }
                catch {
                    weakSelf?.delegate?.didReceiveError(error: error)
                }
        })
        
        dataTask.resume()
    }
    
    func get(fromUrl urlString: String, andHeaders headers: Dictionary<String, String> = [:]) {
        self.send(withMethod: .get, toUrl: urlString, withBody: nil, andHeaders: headers)
    }
    
    func post(toUrl urlString: String, withBody bodyDict: Dictionary<String, Any>, adnHeaders headers: Dictionary<String, String> = [:]) {
        self.send(withMethod: .post, toUrl: urlString, withBody: bodyDict, andHeaders: headers)
    }
    
    func postJSON(toUrl urlString: String, withBody bodyDict: Dictionary<String, Any>, adnHeaders headers: Dictionary<String, String> = [:]) {
        var headersWithJson: Dictionary<String, String> = [:]
        headers.forEach() {headersWithJson[$0.key] = $0.value}
        headersWithJson["Content-Type"] = "application/json"
        self.post(toUrl: urlString, withBody: bodyDict, adnHeaders: headersWithJson)
    }
    
    func put(toUrl urlString: String, withBody bodyDict: Dictionary<String, Any>, adnHeaders headers: Dictionary<String, String> = [:]) {
        self.send(withMethod: .put, toUrl: urlString, withBody: bodyDict, andHeaders: headers)
    }
    
    func putJSON(toUrl urlString: String, withBody bodyDict: Dictionary<String, Any>, adnHeaders headers: Dictionary<String, String> = [:]) {
        var headersWithJson: Dictionary<String, String> = [:]
        headers.forEach() {headersWithJson[$0.key] = $0.value}
        headersWithJson["Content-Type"] = "application/json"
        self.put(toUrl: urlString, withBody: bodyDict, adnHeaders: headersWithJson)
    }
}
