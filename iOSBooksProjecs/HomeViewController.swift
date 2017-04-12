//
//  HomeViewController.swift
//  iOSBooksProjecs
//
//  Created by Cookie on 4/3/17.
//  Copyright © 2017 Cookie. All rights reserved.
//

import UIKit
import CoreData

class HomeViewController: UIViewController, HttpRequesterDelegate {
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
    
    var http: HttpRequester? {
        get {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            return appDelegate.http
        }
    }

    
    
    @IBAction func signinButton(_ sender: Any) {
        let username = self.usernameText.text
        let passHash = self.passwordText.text
        
        let entity = NSEntityDescription.entity(forEntityName: "Users", in: self.managedObjectContext)
        
        let userInfo: NSManagedObject = NSManagedObject(entity: entity!, insertInto: self.managedObjectContext)
        
        userInfo.setValue(username, forKey: username!)
        userInfo.setValue(passHash, forKey: passHash!)
        
        self.managedObjectContext.insert(userInfo)
        
        self.appDelegate.saveContext()
        
//        let user = User(username: username!, passHash: passHash!)
//        let authKey = ""
//        self.http?.putJSON(toUrl: self.url, withBody: user.toDict(), adnHeaders: ["x-auth-key": authKey])
    }

    @IBAction func passwordButton(_ sender: Any) {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.loadData()
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
        self.http?.delegate = self
        
    }
    
    var appDelegate: AppDelegate {
        get {
            return UIApplication.shared.delegate as! AppDelegate
        }
    }
    
    var managedObjectContext: NSManagedObjectContext {
        get {
            return self.appDelegate.persistentContainer.viewContext
        }
    }
    
    func loadData() {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Users")
        do {
            self.user = try self.managedObjectContext.fetch(fetchRequest)
            
            print(user)
        } catch let error as NSError{
            print("The error is \(error.userInfo)")
        }
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
