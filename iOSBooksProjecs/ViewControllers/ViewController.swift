//
//  ViewController.swift
//  iOSBooksProjecs
//
//  Created by Cookie on 4/3/17.
//  Copyright © 2017 Cookie. All rights reserved.
//

import UIKit

class ViewController: UIViewController, HttpRequesterDelegate {
    var http: HttpRequester?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.http = HttpRequester()
        self.http?.delegate = self
        self.http?.get(fromUrl: "http://localhost:3000/api/books")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didReceiveData(data: Any) {
        let arr = data as! [Any]
        arr.forEach { (item) in
            let dict = item as! Dictionary<String, Any>
        }
    }
    
    func didReceiveError(error: Error) {
    
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
