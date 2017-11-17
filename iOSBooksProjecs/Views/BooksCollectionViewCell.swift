//
//  BooksCollectionViewCell.swift
//  iOSBooksProjecs
//
//  Created by Cookie on 4/2/17.
//  Copyright © 2017 Cookie. All rights reserved.
//

import UIKit

class BooksCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    
    var books: [Book] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        addImageViewConstraints()
        //addImageDimViewConstraints()
    }

    func populate(with book: Book, indexPath: IndexPath) {
        if let currentSectionItem = self.sectionItem(withIndexPath: indexPath) {
            self.tag = currentSectionItem
        }
        
        imageView.image = #imageLiteral(resourceName: "placeholderBookImage")
        activityView.startAnimating()
        
        LoadImage.shared.loadImage(withUrl: URL.init(string: book.coverUrl), inCellWith: indexPath) { (image) in
            guard let image = image else {
                self.activityView.stopAnimating()
                return
            }
            
            let loadImageSectionItemInt = self.sectionItem(withIndexPath: indexPath)
            
            if self.tag == loadImageSectionItemInt {
                self.activityView.stopAnimating()
                self.imageView.image = image
            }
        }
    }
    
    func sectionItem(withIndexPath indexPath: IndexPath) -> Int? {
        let section = indexPath.section
        let item = indexPath.item
        let sectionItem = "\(section)\(item)"
        return Int(sectionItem)
    }
    
    func addImageViewConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let imageViewBottomConstraint =
            NSLayoutConstraint(item: imageView, attribute: .bottom,
                               relatedBy: .equal,
                               toItem: contentView, attribute: .bottom,
                               multiplier: 1, constant: 0)
        
        let imageViewTopConstraint =
            NSLayoutConstraint(item: imageView, attribute: .top,
                               relatedBy: .equal,
                               toItem: contentView, attribute: .top,
                               multiplier: 1, constant: 0)
        
        let imageViewLeftConstraint =
            NSLayoutConstraint(item: imageView, attribute: .leading,
                               relatedBy: .equal,
                               toItem: contentView, attribute: .leading,
                               multiplier: 1, constant: 0)
        
        let imageViewRightConstraint =
            NSLayoutConstraint(item: imageView, attribute: .trailing,
                               relatedBy: .equal,
                               toItem: contentView, attribute: .trailing,
                               multiplier: 1, constant: 0)
        
        addConstraint(imageViewBottomConstraint)
        addConstraint(imageViewTopConstraint)
        addConstraint(imageViewLeftConstraint)
        addConstraint(imageViewRightConstraint)
    }
    
    
    
//    func addImageDimViewConstraints() {
//        dimView.translatesAutoresizingMaskIntoConstraints = false
//        let imageViewBottomConstraint =
//            NSLayoutConstraint(item: dimView, attribute: .bottom,
//                              relatedBy: .equal,
//                              toItem: contentView, attribute: .bottom,
//                              multiplier: 1, constant: 0)
//        
//        let imageViewTopConstraint =
//           NSLayoutConstraint(item: dimView, attribute: .top,
//                               relatedBy: .equal,
//                               toItem: contentView, attribute: .top,
//                               multiplier: 1, constant: 0)
//        
//        let imageViewLeftConstraint =
//            NSLayoutConstraint(item: dimView, attribute: .leading,
//                               relatedBy: .equal,
//                               toItem: contentView, attribute: .leading,
//                                 multiplier: 1, constant: 0)
//        
//        let imageViewRightConstraint =
//            NSLayoutConstraint(item: dimView, attribute: .trailing,
//                               relatedBy: .equal,
//                               toItem: contentView, attribute: .trailing,
//                               multiplier: 1, constant: 0)
//        
//        addConstraint(imageViewBottomConstraint)
//        addConstraint(imageViewTopConstraint)
//        addConstraint(imageViewLeftConstraint)
//        addConstraint(imageViewRightConstraint)
//
//    }
}
