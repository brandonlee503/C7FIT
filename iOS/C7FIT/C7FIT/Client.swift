//
//  Client.swift
//  C7FIT
//
//  Created by Brandon Lee on 12/27/16.
//  Copyright © 2016 Brandon Lee. All rights reserved.
//

import Foundation

/**
    Representation of a client
 */
struct Client : ObjectMapper {
    var firstAppointmentDateString: String?
    var birthDateString: String?
    
    var firstName: String?
    var lastName: String?
    var middleName: String?
    var email: String?
    var mobilePhone: String?
    var homePhone: String?
    var workPhone: String?
    var addressLine1: String?
    var addressLine2: String?
    var action: String? // Action result from adding client to class
    var city: String?
    var state: String?
    var country: String?
    var postalCode: String?
    var foreignZip: String?
    var gender: String?
    var emergencyContactName: String?
    var emergencyContactRelationship: String?
    var emergencyContactPhone: String?
    var emergencyContactEmail: String?
    var workExtension: String?
    var birthDate: Date?
    var firstAppointmentDate: Date?
    var referredBy: String?
    var yellowAlert: String?
    var redAlert: String?
    var username: String?
    var password: String?
    var notes: String?
    var id: String?
    var appointmentGenderPreference: String?
    var photoURL: String?
    var isCompany: Bool?
    var liabilityRelease: Bool? // If client has accepted release
    var emailOptIn: Bool?
    var promotionalEmailOptIn: Bool?
    var isProspect: Bool?
    var inactive: Bool?
    var isCompanySpecified: Bool?
    var liabilityReleaseSpecified: Bool?
    var emailOptInSpecified: Bool?
    var isProspectSpecified: Bool?
    var inactiveSpecified: Bool?
    var promotionalEmailOptInSpecified: Bool?
    var homeLocation: Location?
    
    mutating func mapElement(key: String?, value: String?) {
        switch key {
        case "IsCompany"?:
            isCompany = value?.boolValue
        case "LiabilityRelease"?:
            liabilityRelease = value?.boolValue
        case "EmailOptIn"?:
            emailOptIn = value?.boolValue
        case "IsProspect"?:
            isProspect = value?.boolValue
        case "PromotionalEmailOptIn"?:
            promotionalEmailOptIn = value?.boolValue
        case "ID"?:
            id = value
        case "FirstName"?:
            firstName = DataFormatter.concatenate(str1: firstName, str2: value)
        case "LastName"?:
            lastName = DataFormatter.concatenate(str1: lastName, str2: value)
        case "Gender"?:
            gender = value
        case "Email"?:
            email = DataFormatter.concatenate(str1: email, str2: value)
        case "MobilePhone"?:
            mobilePhone = DataFormatter.concatenate(str1: mobilePhone, str2: value)
        case "HomePhone"?:
            homePhone = DataFormatter.concatenate(str1: homePhone, str2: value)
        case "WorkPhone"?:
            workPhone = DataFormatter.concatenate(str1: workPhone, str2: value)
        case "AddressLine1"?:
            addressLine1 = DataFormatter.concatenate(str1: addressLine1, str2: value)
        case "AddressLine2"?:
            addressLine2 = DataFormatter.concatenate(str1: addressLine2, str2: value)
        case "City"?:
            city = DataFormatter.concatenate(str1: city, str2: value)
        case "State"?:
            state = value
        case "Country"?:
            country = value
        case "PostalCode"?:
            postalCode = DataFormatter.concatenate(str1: postalCode, str2: value)
        case "YellowAlert"?:
            yellowAlert = DataFormatter.concatenate(str1: yellowAlert, str2: value)
        case "RedAlert"?:
            redAlert = DataFormatter.concatenate(str1: redAlert, str2: value)
        case "Notes"?:
            notes = DataFormatter.concatenate(str1: notes, str2: value)
        case "Username"?:
            username = DataFormatter.concatenate(str1: username, str2: value)
        case "AppointmentGenderPreference"?:
            appointmentGenderPreference = value
        case "EmergencyContactInfoName"?:
            emergencyContactName = DataFormatter.concatenate(str1: emergencyContactName, str2: value)
        case "EmergencyContactInfoRelationship"?:
            emergencyContactRelationship = value
        case "EmergencyContactInfoPhone"?:
            emergencyContactPhone = DataFormatter.concatenate(str1: emergencyContactPhone, str2: value)
        case "WorkExtension"?:
            workExtension = DataFormatter.concatenate(str1: workExtension, str2: value)
        case "BirthDate"?:
            birthDateString = DataFormatter.concatenate(str1: birthDateString, str2: value)
        case "FirstAppointmentDate"?:
            firstAppointmentDateString = DataFormatter.concatenate(str1: firstAppointmentDateString, str2: value)
        case "Action"?:
            action = DataFormatter.concatenate(str1: action, str2: value)
        default:
            break
        }
    }
    
    mutating func finish() {
        birthDate = DataFormatter.formatDatefromISO(string: birthDateString)
        firstAppointmentDate = DataFormatter.formatDatefromISO(string: firstAppointmentDateString)
    }
}
