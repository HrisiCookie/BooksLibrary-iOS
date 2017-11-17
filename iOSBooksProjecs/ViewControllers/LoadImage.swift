//
//  LoadImage.swift
//  iOSBooksProjecs
//
//  Created by Hristina Bailova on 5/12/17.
//  Copyright © 2017 Cookie. All rights reserved.
//

import UIKit

class LoadImage {

    static let shared = LoadImage()
    let imageCache = NSCache<NSString, UIImage>()
    
    func loadImage(withUrl url: URL?, inCellWith indexPath: IndexPath? = nil, completion: @escaping (UIImage?) -> ()) {
        if let url = url {
            if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
                completion(cachedImage)
            } else {
                HttpRequester.sharedInstance.downloadImage(withURL: url, completion: { [weak self] (image) in
                    DispatchQueue.main.async {
                        guard let strongSelf = self else {return}
                        if let image = image {
                            strongSelf.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                            completion(image)
                        } else {
                            completion(nil)
                        }
                    }
                })
            }
        } else {
            completion(nil)
            
        }
    }
}
