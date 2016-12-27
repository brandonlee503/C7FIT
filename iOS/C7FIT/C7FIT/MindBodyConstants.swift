//
//  MindBodyConstants.swift
//  C7FIT
//
//  Created by Brandon Lee on 12/25/16.
//  Copyright © 2016 Brandon Lee. All rights reserved.
//

import Foundation

struct MindBodyConstants {
    
    // API Endpoints
    static let AppointmentService = "https://api.mindbodyonline.com/0_5/AppointmentService.asmx"
    static let ClassService = "https://api.mindbodyonline.com/0_5/ClassService.asmx"
    static let ClientService = "https://api.mindbodyonline.com/0_5/ClientService.asmx"
    static let SaleService = "https://api.mindbodyonline.com/0_5/SaleService.asmx"
    static let SiteService = "https://api.mindbodyonline.com/0_5/SiteService.asmx"
    static let StaffService = "https://api.mindbodyonline.com/0_5/StaffService.asmx"
    
    static let ContentType = "text/xml; charset=utf-8"
    
    enum UserAccessLevel: Int {
        case UserAccessLevelNone     = 0
        case UserAccessLevelConsumer = 1
        case UserAccessLevelStaff    = 3
        case UserAccessLevelPartner  = 7
        case UserAccessLevelOwner    = 15
        case UserAccessLevelAdmin    = 31
    }
}
