//
//  EbayItemDetail.swift
//  C7FIT
//
//  Created by Brandon Lee on 4/26/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import Foundation

/**
    A model representation of an Ebay item fetched from itemID query
 */
struct EbayItemDetail {
//    let mainItem: EbayItem?
    let mainImage: URL?
    var additionalImages = [URL?]()
    let shortDescription: String?
    let location: String?

    // A bit ugly with nested JSON, but it's done how Apple says - https://developer.apple.com/swift/blog/?id=37
    init(itemJSON: [String: Any]) {
//        mainItem = eBayItem
        if let imageDict = itemJSON["image"] as? [String: Any] {
            mainImage = URL(string: imageDict["imageUrl"] as! String)
        } else {
            mainImage = nil
        }

        if let additionalImagesDict = itemJSON["additionalImages"] as? [[String: Any]] {
            for image in additionalImagesDict {
                additionalImages.append(URL(string: image["imageUrl"] as! String))
            }
        }

        shortDescription = itemJSON["shortDescription"] as! String?
        if let itemLocationDict = itemJSON["itemLocation"] as? [String: Any] {
            location = itemLocationDict["city"] as! String?
        } else {
            location = nil
        }

//        if let priceDict = itemJSON["price"] as? [String: Any] {
//            price = priceDict["value"] as! String?
//        } else {
//            price = nil
//        }
    }
}
