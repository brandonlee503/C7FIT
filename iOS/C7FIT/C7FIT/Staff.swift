//
//  Staff.swift
//  C7FIT
//
//  Created by Brandon Lee on 12/27/16.
//  Copyright © 2016 Brandon Lee. All rights reserved.
//

import Foundation

/**
    Representation of a staff member
 */
struct Staff : ObjectMapper {
    
    var firstName: String?
    var lastName: String?
    var name: String?
    var email: String?
    var mobilePhone: String?
    var homePhone: String?
    var workPhone: String?
    var address: String?
    var address2: String?
    var city: String?
    var state: String?
    var country: String?
    var postalCode: String?
    var foreignZip: String?
    var bio: String?
    var id: String?
    var imageURL: String?
    var appointmentTrn: Bool? // Staff appointment status
    var independentContractor: Bool?
    var alwaysAllowDoubleBooking: Bool? // Overlapping booking status
    var reservationTrn: Bool? // Teacher status
    var isMale: Bool?
    var loginLocations: Array<Any>?
    var accessLevel: MindBodyConstants.UserAccessLevel?
    
    mutating func mapElement(key: String?, value: String?) {
        switch key {
        case "AppointmentTrn"?:
            appointmentTrn = value?.boolValue
        case "ReservationTrn"?:
            reservationTrn = value?.boolValue
        case "IndependentContractor"?:
            independentContractor = value?.boolValue
        case "AlwaysAllowDoubleBooking"?:
            alwaysAllowDoubleBooking = value?.boolValue
        case "ID"?:
            id = value
        case "Name"?:
            name = DataFormatter.concatenate(str1: name, str2: value)
        case "FirstName"?:
            firstName = DataFormatter.concatenate(str1: firstName, str2: value)
        case "LastName"?:
            lastName = DataFormatter.concatenate(str1: lastName, str2: value)
        case "isMale"?:
            isMale = value?.boolValue
        case "Email"?:
            email = DataFormatter.concatenate(str1: email, str2: value)
        case "MobilePhone"?:
            mobilePhone = value
        case "HomePhone"?:
            homePhone = value
        case "WorkPhone"?:
            workPhone = value
        case "Address"?:
            address = DataFormatter.concatenate(str1: address, str2: value)
        case "Address2"?:
            address2 = DataFormatter.concatenate(str1: address2, str2: value)
        case "City"?:
            city = DataFormatter.concatenate(str1: city, str2: value)
        case "State"?:
            state = DataFormatter.concatenate(str1: state, str2: value)
        case "Country"?:
            country = DataFormatter.concatenate(str1: country, str2: value)
        case "PostalCode"?:
            postalCode = DataFormatter.concatenate(str1: postalCode, str2: value)
        case "ForeignZip"?:
            foreignZip = DataFormatter.concatenate(str1: foreignZip, str2: value)
        case "Bio"?:
            bio = DataFormatter.concatenate(str1: bio, str2: value)
        case "ImageURL"?:
            imageURL = DataFormatter.concatenate(str1: imageURL, str2: value)
        default:
            break
        }
    }
    
    func finish() {
        
    }
}
