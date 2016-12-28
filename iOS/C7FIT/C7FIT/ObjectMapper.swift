//
//  ObjectMapper.swift
//  C7FIT
//
//  Created by Brandon Lee on 12/27/16.
//  Copyright © 2016 Brandon Lee. All rights reserved.
//

import Foundation

/**
    Protocol for all API response models
 */
protocol ObjectMapper {
    mutating func mapElement(key: String?, value: String?)
    mutating func finish()
}
