//
//  StringExtensions.swift
//  C7FIT
//
//  Created by Brandon Lee on 12/27/16.
//  Copyright © 2016 Brandon Lee. All rights reserved.
//

import Foundation

/**
    Extensions for Swift's String
 */
extension String {
    var boolValue: Bool {
        return NSString(string: self).boolValue
    }
    
    var intValue: Int {
        return NSString(string: self).integerValue
    }
    
    var doubleValue: Double {
        return NSString(string: self).doubleValue
    }
    
}
