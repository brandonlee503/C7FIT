//
//  UserCredentials.swift
//  C7FIT
//
//  Created by Brandon Lee on 12/24/16.
//  Copyright © 2016 Brandon Lee. All rights reserved.
//

import Foundation

// Singleton Abstraction of User Credentials for MindBody API Access (Staff/Owner)
class UserCredentials {
    static let sharedInstance: UserCredentials = {
        let instance = UserCredentials(username: "Username", password: "Password", siteID: "siteID")
        return instance
    }()
    
    let Username: String?
    let Password: String?
    let SiteID: String? // The user's studio/site ID
    
    init(username: String?, password: String?, siteID: String?) {
        Username = username
        Password = password
        SiteID = siteID
    }
}
