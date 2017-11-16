//
//  DetailBookViewController.swift
//  iOSBooksProjecs
//
//  Created by Cookie on 4/2/17.
//  Copyright © 2017 Cookie. All rights reserved.
//

import UIKit

class DetailBookViewController: UIViewController, HttpRequesterDelegate {
    
    @IBOutlet weak var detailViewImage: UIImageView!
    @IBOutlet weak var detailViewText: UITextView!
    @IBOutlet weak var detailViewButton: UIButton!
    @IBOutlet weak var detailViewLabel: UILabel!
    
    var bookId: String?
    var book: Book?
    
    var url: String {
        get {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            return "\(appDelegate.baseUrl)/books"
        }
    }
    
    var http: HttpRequester? {
        get {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            return appDelegate.http
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadBookDetails()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadBookDetails() {
        self.http?.delegate = self
        let url = "\(self.url)/\(self.bookId!)"
        self.showLoadingScreen()
        self.http?.get(fromUrl: url)
    }
    
    func didReceiveData(data: Any) {
        let dict = data as! Dictionary<String, Any>
        self.book = Book(withDict: dict)
        self.updateUI()
    }
    
    func updateUI() {
        DispatchQueue.main.async {
            self.detailViewLabel.text = self.book?.title
            self.detailViewText.text = self.book?.bookDescription
            self.detailViewImage.image = {
                let url = URL(string: (self.book?.coverUrl)!)
                do {
                let imageData =  try Data(contentsOf: url!)
                let image = UIImage(data: imageData)
                return image
                } catch let err as NSError {
                    print("Error: \(err.userInfo)")
                    return nil
                }
            }()
            self.hideLoadingScreen()
        }
    }
    
    
    // MARK: - Navigation
    
    //     In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    
}
