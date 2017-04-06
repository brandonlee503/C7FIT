//
//  EbayItemCategory.swift
//  C7FIT
//
//  Created by Brandon Lee on 3/7/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import Foundation

/**
    A model representation of an item category
 */
struct EbayItemCategory {
    let title: String
    var items: [EbayItem]

    init(title: String, items: [EbayItem]) {
        self.title = title
        self.items = items
    }
}
