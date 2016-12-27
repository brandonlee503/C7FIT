//
//  ServiceCategory.swift
//  C7FIT
//
//  Created by Brandon Lee on 12/27/16.
//  Copyright © 2016 Brandon Lee. All rights reserved.
//

import Foundation

/**
    Representation of a program for classes and appointments
 */
struct ServiceCategory : ObjectMapper {
    var id: String?
    var name: String?
    var scheduleType: String?
    var cancelOffset: Int?
    
    mutating func mapElement(key: String?, value: String?) {
        switch key {
        case "ID"?:
            id = DataFormatter.concatenate(str1: id, str2: value)
        case "Name"?:
            name = DataFormatter.concatenate(str1: name, str2: value)
        case "ScheduleType"?:
            scheduleType = value
        case "CancelOffset"?:
            cancelOffset = value?.intValue
        default:
            break
        }
    }
    
    func finish() {

    }
}
