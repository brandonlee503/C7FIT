//
//  UIImageView+Download.swift
//  C7FIT
//
//  Created by Brandon Lee on 3/8/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import Foundation
import UIKit

/**
    Extensions for UIImageView
 */
public extension UIImageView {
    
    public func downloadFrom(urlString: String, imageMode: UIViewContentMode) {
        guard let url = URL(string: urlString) else { return }
        downloadFrom(url: url, imageMode: contentMode)
    }
    
    public func downloadFrom(url: URL, imageMode: UIViewContentMode) {
        contentMode = imageMode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }.resume()
    }
}
