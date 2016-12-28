//
//  ClassDescription.swift
//  C7FIT
//
//  Created by Brandon Lee on 12/27/16.
//  Copyright © 2016 Brandon Lee. All rights reserved.
//

import Foundation

/**
    Representation of a class description
 */
struct ClassDescription : ObjectMapper {
    var lastUpdated: String?
    var imageURL: String?
    var id: String?
    var name: String?
    var description: String?
    var prerequisite: String?
    var notes: String?
    var lastUpdated1: NSDate?
    var serviceCategory: ServiceCategory?
    var sessionType: SessionType?

    mutating func mapElement(key: String?, value: String?) {
        switch key {
        case "ID"?:
            id = DataFormatter.concatenate(str1: id, str2: value)
        case "Name"?:
            name = DataFormatter.concatenate(str1: name, str2: value)
        case "ImageURL"?:
            imageURL = DataFormatter.concatenate(str1: imageURL, str2: value)
        case "Description"?:
            description = DataFormatter.concatenate(str1: description, str2: value)
        case "Prereq"?:
            prerequisite = DataFormatter.concatenate(str1: prerequisite, str2: value)
        case "Notes"?:
            notes = DataFormatter.concatenate(str1: notes, str2: value)
        case "LastUpdated"?:
            lastUpdated = DataFormatter.concatenate(str1: lastUpdated, str2: value)
        default:
            break
        }
    }
    
    func finish() {

    }
}
