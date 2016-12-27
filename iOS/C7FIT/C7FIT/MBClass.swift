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
    var webBooked: Int?
    var semesterID: String?
    var isCanceled: Bool?
    var isSubstitute: Bool?
    var isActive: Bool?
    var isWaitlistAvailable: Bool?
    var isEnrolled: Bool?
    var hideCancel: Bool?
    var isAvailable: Bool?
    var startDateTime: NSDate?
    var endDateTime: NSDate?
    
    // TODO: Location, ClassDescription, Staff, Client
    
    func mapElement(key: String?, value: String?) {
        //TODO
    }
    
    func finish() {
        
    }
}
