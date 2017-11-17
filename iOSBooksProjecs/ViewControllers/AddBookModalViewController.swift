//
//  AddBookModalViewController.swift
//  iOSBooksProjecs
//
//  Created by Cookie on 4/3/17.
//  Copyright © 2017 Cookie. All rights reserved.
//

import UIKit

protocol AddBookModalDelegate {
    func didCreateBook(book: Book?)
}

class AddBookModalViewController: UIViewController {

    @IBOutlet weak var textDescription: UITextView!
    @IBOutlet weak var textTitle: UITextField!
    
    var delegate: AddBookModalDelegate?
    
    var url: String {
        get {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            return "\(appDelegate.baseUrl)/books"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        HttpRequester.sharedInstance.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func save(_ sender: Any) {
        let title = self.textTitle.text
        let description = self.textDescription.text
        
        let book = Book(withTitle: title!, bookDescription: description!, andCoverUrl: "")
        let bookDict = book.toDict()
        
//        HttpRequester.sharedInstance.postJSON(toUrl: self.url, withBody: bookDict)
    }
    
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func didReceiveData(data: Any) {
        self.dismiss(animated: true, completion: nil)
        self.delegate?.didCreateBook(book: nil)
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
