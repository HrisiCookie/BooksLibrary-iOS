//
//  HttpViewController.swift
//  iOSBooksProjecs
//
//  Created by Cookie on 4/2/17.
//  Copyright © 2017 Cookie. All rights reserved.
//

//import UIKit
//
//class HttpViewController: UIViewController {
//    var url: URL {
//        get {
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            return URL(string: appDelegate.baseUrl + "/books")!
//        }
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        //get the url
//        let url = self.url
//        
//        //create the NSMutableURLRequest
//        let request = NSMutableURLRequest(url: url)
//        request.httpMethod = "GET"
//            
//        //send the request with URLSession
//        let urlRequest = request as URLRequest
//        let session = URLSession.shared.dataTask(with: urlRequest) {
//            (data, response, error) in
//            do {
//                let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
//                print(json)
//            } catch {
//                
//            }
//        }
//        
//        session.resume()
//    }

//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//         Dispose of any resources that can be recreated.
//    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

//}
