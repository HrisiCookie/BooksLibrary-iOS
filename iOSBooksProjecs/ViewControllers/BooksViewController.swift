//
//  BooksViewController.swift
//  iOSBooksProjecs
//
//  Created by Cookie on 4/2/17.
//  Copyright © 2017 Cookie. All rights reserved.
//

import UIKit
import Presentr

class BooksViewController: UIViewController
{
    @IBOutlet weak var collectionView: UICollectionView?
  
    var pageIndex = 1
    var books: [Book] = []
    
    let presenter = Presentr(presentationType: .popup)
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.transitionType = .coverHorizontalFromRight
        
        loadMore(withPageIndex: pageIndex)
        
        // Register cell classes
        collectionView?.register(UINib(nibName: "BooksCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BooksCollectionViewCell")
    }
    
    func showDetails(of book: Book) {
        let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailBookViewController") as? DetailBookViewController
        nextVC?.bookId = book.id
        print("book id: \(String(describing: book.id))")
        
        if let nextVC = nextVC {
            navigationController?.show(nextVC, sender: self)
        }
    }
    
    @IBAction func addRightBarNavigationItem(_ sender: UIBarButtonItem) {
        self.showAddModal()
    }
    
    func showAddModal() {
        let nextVC = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "AddBookModalViewController") as? AddBookModalViewController
        
        nextVC?.delegate = self
        
        if let nextVC = nextVC {
            customPresentViewController(presenter, viewController: nextVC, animated: true, completion: nil)
        }
    }
    
    func loadMore(withPageIndex pageIndex: Int) {
        print("Page index: \(pageIndex)")
        let url = APIURLFactorty().loadMoreBooks(pageIndex: self.pageIndex)
        
        HttpRequester.sharedInstance.requestJSON(withMethod: .get, toUrl: url) { [weak self] (data, statusCode, error) in
            guard let strongSelf = self else { return }
            guard let statusCode = statusCode else {
                let alert = UIAlertController(title: "Alert", message: "Server is not responding!", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                strongSelf.present(alert, animated: true, completion: nil)
                return
            }
            
            if statusCode.isSuccess {
                strongSelf.pageIndex += 1
                let dataArray = data as! [Dictionary<String, Any>]
                if dataArray.count != 0 {
                    (dataArray.map(){Book(withDict: $0)})
                        .forEach(){
                            strongSelf.books.append($0)}
                    
                    DispatchQueue.main.async {
                        strongSelf.collectionView?.reloadData()
                    }
                }
            }
            else {
                let alert = UIAlertController(title: "Alert", message: "\(statusCode.description)", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                alert.present(alert, animated: true, completion: nil)
                print("\(statusCode.description)")
            }
        }
    }
}

// MARK: UICollectionViewDataSource
extension BooksViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let book = books[indexPath.row]
        showDetails(of: book)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let booksCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BooksCollectionViewCell", for: indexPath) as? BooksCollectionViewCell
        guard let cell = booksCell else {
            return UICollectionViewCell()
        }
        
        if(indexPath.row == books.count - 1){
            loadMore(withPageIndex: pageIndex)
        }
        
        let currentBook = books[indexPath.item]
        
        cell.populate(with: currentBook, indexPath: indexPath)
        
        return cell
    }
}


//MARK: - AddBookModalDelegate
extension BooksViewController: AddBookModalDelegate {
    func didCreateBook(book: Book?) {
        loadMore(withPageIndex: pageIndex)
    }
   }

//MARK: - UICollectionViewDelegateFlowLayout
extension BooksViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width / 2.2
        let height =
            (collectionView.frame.width > collectionView.frame.height)
                ? collectionView.frame.height
                : collectionView.frame.height / 3
        
        return CGSize(width: width, height: height)
    }
}

