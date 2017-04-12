//
//  BooksViewController.swift
//  iOSBooksProjecs
//
//  Created by Cookie on 4/2/17.
//  Copyright © 2017 Cookie. All rights reserved.
//

import UIKit
import Presentr

//private let reuseIdentifier = "Book cell"

class BooksViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, HttpRequesterDelegate, AddBookModalDelegate {
    var pageIndex = 0
    var books: [Book] = []
    
    let presenter: Presentr = {
        let presenter = Presentr(presentationType: .popup)
        presenter.transitionType = .coverHorizontalFromRight
        return presenter
    }()
    
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
//    var books: [Books] = []
//
    func didCreateBook(book: Book?) {
//        self.loadBooks()
        self.loadMore()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.http?.delegate = self
        self.showLoadingScreen()
//        self.http?.get(fromUrl: "http://localhost:3000/api/books")
    
//
        // Register cell classes
        self.collectionView!.register(UINib(nibName: "BooksCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "book-cell")
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(BooksViewController.showAddModal))
        self.loadMore()
    }
    
    func showAddModal() {
        let nextVC = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "modal-add-book") as! AddBookModalViewController
        
        nextVC.delegate = self
        
        self.customPresentViewController(self.presenter, viewController: nextVC, animated: true, completion: nil)
    }
//
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
//
    func didReceiveData(data: Any) {
        let dataArray = data as! [Dictionary<String, Any>]
        
//        self.books = dataArray.map(){Book(withDict: $0)}
        (dataArray.map(){Book(withDict: $0)})
            .forEach(){ self.books.append($0)}
        
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
            self.hideLoadingScreen()
            self.hideLoadingScreen()
            //stop loading
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width / 3.2
        let height =
            (collectionView.frame.width > collectionView.frame.height)
            ? collectionView.frame.height
            : collectionView.frame.height / 3
        
        return CGSize(width: width, height: height)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let book = self.books[indexPath.row]
        self.showDetails(of: book)
    }
    
    func showDetails(of book: Book) {
        let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "book-details") as! DetailBookViewController
        nextVC.bookId = book.id
        
        self.navigationController?.show(nextVC, sender: self)
    }
    

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
//
//
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.books.count
    }
// 
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "book-cell", for: indexPath) as! BooksCollectionViewCell
        if(indexPath.row == self.books.count - 1){
            self.loadMore()
        }
        
        let image: UIImage? = {
            print("\(indexPath.row): \(self.books[indexPath.row].coverUrl)")
            if(self.books[indexPath.row].coverUrl == "") {
                return nil
            }
                let url = URL(string: self.books[indexPath.row].coverUrl)
                do {
                    let imageData = try Data(contentsOf: url!)
                    let image = UIImage(data: imageData)!
                    return image
                } catch let err as NSError {
                    print(err.userInfo)
                    return nil
                }
        }()
//
        cell.imageView.image = image
//        cell.backgroundColor = .yellow
        
        return cell
    }
    
    func loadMore() {
        // start loading
        self.showLoadingScreen()
        self.pageIndex += 1
        let url = "\(self.url)?page=\(self.pageIndex)"
        self.http?.get(fromUrl: url)
    }

    
    
//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        
//        var nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "details") as! DetailBookControllerViewController
//        nextVC = self.
//    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
