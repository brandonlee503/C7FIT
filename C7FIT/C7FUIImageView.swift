//
//  C7FUIImageView.swift
//  C7FIT
//
//  Created by Brandon Lee on 3/8/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import Foundation
import UIKit

/**
    Custom UIImageView for downloading images from URLs and caching images.
 */
class C7FUIImageView: UIImageView {
    
    // MARK: - Constants
    
    let imageCache = NSCache<NSString, AnyObject>()
    
    // MARK: - Properties
    
    var imageURLString: String?
    
    func downloadImageFrom(urlString: String, imageMode: UIViewContentMode) {
        guard let url = URL(string: urlString) else { return }
        downloadImageFrom(url: url, imageMode: imageMode)
    }
    
    func downloadImageFrom(url: URL, imageMode: UIViewContentMode) {
        contentMode = imageMode
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) as? UIImage {
            self.image = cachedImage
        } else {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    let imageToCache = UIImage(data: data)
                    self.imageCache.setObject(imageToCache!, forKey: url.absoluteString as NSString)
                    self.image = imageToCache
                }
            }.resume()
        }
    }
}
