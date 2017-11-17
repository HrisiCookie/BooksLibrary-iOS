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
    
    static let sharedInstance = HttpRequester()
//
    func send(withMethod method: HttpMethod, toUrl url: URL?, withBody bodyDict: [String: Any]? = nil,
              andHeaders headers: [String: String] = [:], completion:  @escaping (Data?, URLResponse?, Error?) -> Void) {
        var request: URLRequest
        
        guard let url = url else {
            completion(nil, nil, nil)
            return
        }
        
        request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let bodyDict = bodyDict, (method == .put || method == .post) {
            do {
                let body = try JSONSerialization.data(withJSONObject: bodyDict, options: .prettyPrinted)
                request.setValue("application/json", forHTTPHeaderField: "Content-type")
                request.httpBody = body
            } catch {
                print("ERROR json serialization for url: \(url): \(error)")
            }
        }
        
        headers.forEach() {request.setValue($0.value, forHTTPHeaderField: $0.key)}
        let dataTask = URLSession.shared.dataTask(with: request, completionHandler:
            {bodyData, response, error in
            completion(bodyData, response, error)
        })
        
        dataTask.resume()
    }
    
    func requestJSON(withMethod method: HttpMethod, toUrl url: URL?, withBody bodyDict: [String: Any]? = nil,
                     andHeaders headers: [String: String] = [:], completion: @escaping (Any?, HTTPStatusCode?, Error?) -> Void) {
        send(withMethod: method, toUrl: url) { (bodyData, response, error) in
            guard let bodyData = bodyData, error == nil else {
            if let response = response {
                completion(nil, HTTPStatusCode.init(HTTPResponse: response as? HTTPURLResponse), error)
                print("ERROR: response for \(String(describing: url)) is \(response), error: \(String(describing: error))")
            } else {
                completion(nil, nil, error)
                print("ERROR: response for \(String(describing: url)) is nil, error: \(String(describing: error))")
            }
                return
            }
            guard let response = response else {
                completion(nil, nil, nil)
                print("ERROR: response for \(String(describing: url)) is nil")
                return
            }
        
            let httpResponse = response as? HTTPURLResponse
        
            do {
                let body = try JSONSerialization.jsonObject(with: bodyData, options: .allowFragments)
                completion(body, HTTPStatusCode.init(HTTPResponse: httpResponse), nil)
            }
            catch let jsonError {
                completion(nil,  HTTPStatusCode.init(HTTPResponse: httpResponse), jsonError)
            }
        }
    }

    func downloadImage(withURL url: URL?, completion: @escaping (UIImage?) -> ()) {
        send(withMethod: .get, toUrl: url) { (bodyData, response, error) in
            guard let bodyData = bodyData else {
                completion(nil)
                return
            }

            do {
                let image = UIImage(data: bodyData)
                completion(image)
            }
            catch let err {
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
}
