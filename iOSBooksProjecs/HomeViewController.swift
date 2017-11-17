//
//  HomeViewController.swift
//  iOSBooksProjecs
//
//  Created by Cookie on 4/3/17.
//  Copyright © 2017 Cookie. All rights reserved.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {
    var user: [NSManagedObject] = []

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    var url: String {
        get {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            return "\(appDelegate.baseUrl)/users/auth"
        }
    }

    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadUserInfo(){
    }
    
    var appDelegate: AppDelegate {
        get {
            return UIApplication.shared.delegate as! AppDelegate
        }
    }
}
