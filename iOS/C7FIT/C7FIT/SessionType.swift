//
//  SessionType.swift
//  C7FIT
//
//  Created by Brandon Lee on 12/27/16.
//  Copyright © 2016 Brandon Lee. All rights reserved.
//

import Foundation

/**
    Representation of a type of session
 */
struct SessionType : ObjectMapper {
    var defaultTimeLength: Int?
    var serviceCategoryId: String?
    var numberDeducted: Int?
    var id: String?
    var name: String?
    
    mutating func mapElement(key: String?, value: String?) {
        switch key {
        case "ID"?:
            id = DataFormatter.concatenate(str1: id, str2: value)
        case "Name"?:
            name = DataFormatter.concatenate(str1: name, str2: value)
        case "DefaultTimeLength"?:
            defaultTimeLength = value?.intValue
        case "NumDeducted"?:
            numberDeducted = value?.intValue
        case "ProgramID"?:
            serviceCategoryId = value
        default:
            break
        }
    }
    
    func finish() {

    }
}
