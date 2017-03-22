//
//  String+Conversions.swift
//  C7FIT
//
//  Created by Brandon Lee on 12/27/16.
//  Copyright © 2016 Brandon Lee. All rights reserved.
//

import Foundation

/**
    Extensions for Swift's String
 */
public extension String {
    public var boolValue: Bool {
        return NSString(string: self).boolValue
    }
    
    public var intValue: Int {
        return NSString(string: self).integerValue
    }
    
    public var doubleValue: Double {
        return NSString(string: self).doubleValue
    }
    
}
