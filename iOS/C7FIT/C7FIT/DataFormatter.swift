//
//  DataFormatter.swift
//  C7FIT
//
//  Created by Brandon Lee on 12/24/16.
//  Copyright © 2016 Brandon Lee. All rights reserved.
//

import Foundation

struct DataFormatter {
    
    /**
        Converts Date to ISO formatted string
     
        - Parameter date: Date to convert
        - Returns: String Formatted ISO String
    */
    static func formatISOfromDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US")
        formatter.timeZone = TimeZone(abbreviation: "PST")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        return formatter.string(from: date)
    }
    
    /**
        Custom concatenate function
        - returns: Concatenated string if not nil
     */
    static func concatenate(str1: String?, str2: String?) -> String {
        return [str1, str2].flatMap{$0}.joined(separator: "")
    }
}
