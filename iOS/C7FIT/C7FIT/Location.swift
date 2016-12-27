//
//  Location.swift
//  C7FIT
//
//  Created by Brandon Lee on 12/27/16.
//  Copyright © 2016 Brandon Lee. All rights reserved.
//

import Foundation

/**
    Representation of a location
 */
struct Location : ObjectMapper {
    var businessID: Int?
    var siteID: Int?
    var businessDescription: String?
    var additionalImageURLs: Array<Any>?
    var facilitySquareFeet: Int?
    var treatmentRooms: Int?
    var isProSpaFinderSite: Bool?
    var hasClasses: Bool?
    var phoneExtension: String?
    var id: String?
    var name: String?
    var address: String?
    var address2: String?
    var tax1: Double?
    var tax2: Double?
    var tax3: Double?
    var tax4: Double?
    var tax5: Double?
    var phone: String?
    var city: String?
    var stateProvCode: String?
    var postalCode: String?
    var latitude: Double?
    var longitude: Double?
    var distanceInMiles: Double?
    var imageURL: String?
    var description: String?
    var hasSite: Bool? // If location has MB site for consumers
    var canBook: Bool?
    
    mutating func mapElement(key: String?, value: String?) {
        switch key {
        case "BusinessID"?:
            businessID = value?.intValue
        case "SiteID"?:
            siteID = value?.intValue
        case "BusinessDescription"?:
            businessDescription = DataFormatter.concatenate(str1: businessDescription, str2: value)
        case "FacilitySquareFeet"?:
            facilitySquareFeet = value?.intValue
        case "TreatmentRooms"?:
            treatmentRooms = value?.intValue
        case "ProSpaFinderSite"?:
            isProSpaFinderSite = value?.boolValue
        case "HasClasses"?:
            hasClasses = value?.boolValue
        case "PhoneExtension"?:
            phoneExtension = value
        case "ID"?:
            id = value
        case "Name"?:
            name = value
        case "Address"?:
            address = value
        case "Address2"?:
            address2 = value
        case "Tax1"?:
            tax1 = value?.doubleValue
        case "Tax2"?:
            tax2 = value?.doubleValue
        case "Tax3"?:
            tax3 = value?.doubleValue
        case "Tax4"?:
            tax4 = value?.doubleValue
        case "Tax5"?:
            tax5 = value?.doubleValue
        case "Phone"?:
            phone = value
        case "City"?:
            city = value
        case "StateProvCode"?:
            stateProvCode = value
        case "PostalCode"?:
            postalCode = value
        case "Latitude"?:
            latitude = value?.doubleValue
        case "Longitude"?:
            longitude = value?.doubleValue
        case "DistanceInMiles"?:
            distanceInMiles = value?.doubleValue
        case "ImageURL"?:
            imageURL = value
        case "Description"?:
            description = value
        case "HasSite"?:
            hasSite = value?.boolValue
        case "CanBook"?:
            canBook = value?.boolValue
        default:
            break
        }
    }
    
    func finish() {
    
    }
    
}
