//
//  MBClass.swift
//  C7FIT
//
//  Created by Brandon Lee on 12/27/16.
//  Copyright © 2016 Brandon Lee. All rights reserved.
//

import Foundation

/**
    Representation of a MindBody Classs
 */
struct MBClass : ObjectMapper {
    var startDateString: String?
    var endDateString: String?
    
    var classScheduleID: String?
    var id: String?
    var maxCapacity: Int?
    var webCapacity: Int?
    var totalBooked: Int?
    var totalBookedWaitlist: Int?
    var webBooked: Bool?
    var semesterID: String?
    var isCanceled: Bool?
    var isSubstitute: Bool?
    var isActive: Bool?
    var isWaitlistAvailable: Bool?
    var isEnrolled: Bool?
    var hideCancel: Bool?
    var isAvailable: Bool?
    var startDateTime: Date?
    var endDateTime: Date?
    var location: Location?
    var classDescription: ClassDescription?
    var staff: Staff?
    var client: Client?
    
    mutating func mapElement(key: String?, value: String?) {
        switch key {
        case "ClassScheduleID"?:
            classScheduleID = DataFormatter.concatenate(str1: classScheduleID, str2: value)
        case "MaxCapacity"?:
            maxCapacity = value?.intValue
        case "WebCapacity"?:
            webCapacity = value?.intValue
        case "TotalBooked"?:
            totalBooked = value?.intValue
        case "TotalBookedWaitlist"?:
            totalBookedWaitlist = value?.intValue
        case "WebBooked"?:
            webBooked = value?.boolValue
        case "SemesterID"?:
            semesterID = DataFormatter.concatenate(str1: semesterID, str2: value)
        case "IsCanceled"?:
            isCanceled = value?.boolValue
        case "Substitute"?:
            isSubstitute = value?.boolValue
        case "Active"?:
            isActive = value?.boolValue
        case "IsWaitlistAvailable"?:
            isWaitlistAvailable = value?.boolValue
        case "IsEnrolled"?:
            isEnrolled = value?.boolValue
        case "HideCancel"?:
            hideCancel = value?.boolValue
        case "ID"?:
            id = DataFormatter.concatenate(str1: id, str2: value)
        case "IsAvailable"?:
            isAvailable = value?.boolValue
        case "StartDateTime"?:
            startDateString = DataFormatter.concatenate(str1: startDateString, str2: value)
        case "EndDateTime"?:
            endDateString = DataFormatter.concatenate(str1: endDateString, str2: value)
        default:
            break
        }
    }
    
    mutating func finish() {
        startDateTime = DataFormatter.formatDatefromISO(string: startDateString)
        endDateTime = DataFormatter.formatDatefromISO(string: endDateString)
    }
}
