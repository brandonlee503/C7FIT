//
//  eBayItem.swift
//  C7FIT
//
//  Created by Brandon Lee on 3/5/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import Foundation

/**
    A model representation of an eBay item
 */
struct eBayitem {
    let mainImage: String?
    var additionalImages: [String]?
    let title: String?
    let price: String?
    let shippingCost: String?
    let webURL: String?
    
    // A bit ugly with nested JSON, but it's done how Apple says - https://developer.apple.com/swift/blog/?id=37
    init(itemJSON: [String: Any]) {
        if let imageDict = itemJSON["image"] as? [String: Any] {
            mainImage = imageDict["imageURL"] as! String?
        } else {
            mainImage = nil
        }
        
        if let addImagesDict = itemJSON["additionalImages"] as? [String: Any] {
            for image in addImagesDict {
                additionalImages?.append(image.value as! String)
            }
        } else {
            additionalImages = nil
        }
        
        additionalImages = itemJSON["additionalImages"] as! [String]?
        
        title = itemJSON["title"] as! String?
        
        if let priceDict = itemJSON["price"] as? [String: Any] {
            price = priceDict["value"] as! String?
        } else {
            price = nil
        }
        
        if let shippingOptionsDict = itemJSON["shippingOptions"] as? [String: Any], let shippingCostDict = shippingOptionsDict["shippingCost"] as? [String: Any] {
            shippingCost = shippingCostDict["value"] as! String?
        } else {
            shippingCost = nil
        }
        
        webURL = itemJSON["itemWebUrl"] as! String?
    }
}
