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
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        [unowned self] in
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.center = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        self.addSubview(activityIndicator)
        return activityIndicator
    }()

    func downloadImageFrom(urlString: String, imageMode: UIViewContentMode) {
        guard let url = URL(string: urlString) else { return }
        downloadImageFrom(url: url, imageMode: imageMode)
    }

    func downloadImageFrom(url: URL, imageMode: UIViewContentMode) {
        self.activityIndicator.startAnimating()
        contentMode = imageMode
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) as? UIImage {
            self.image = cachedImage
        } else {
            URLSession.shared.dataTask(with: url) { data, _, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    if let imageToCache = UIImage(data: data) {
                        self.imageCache.setObject(imageToCache, forKey: url.absoluteString as NSString)
                        self.image = imageToCache
                    } else {
                        self.image = nil
                    }
                }
            }.resume()
        }
    }
    
    /**
         Helper method to download images from Firebase's new storage database protocol
     */
    func downloadImageFromFirebase(url: URL, imageMode: UIViewContentMode) {
        let firebaseDataManager = FirebaseDataManager()
        firebaseDataManager.generateFirebaseDownloadURL(url: url) { firebaseURL in
            if let firebaseURL = firebaseURL {
                self.downloadImageFrom(url: firebaseURL, imageMode: imageMode)
            } else {
                print("downloadImageFromFirebase() error")
            }
        }
    }
}
