//
//  SourceCredentials.swift
//  C7FIT
//
//  Created by Brandon Lee on 12/24/16.
//  Copyright © 2016 Brandon Lee. All rights reserved.
//

import Foundation

/**
    Singleton Abstraction of Source Credentials for MindBody API Access
 */
class SourceCredentials {
    static let sharedInstance: SourceCredentials = {
        let instance = SourceCredentials(sourceName: "SourceName", password: "Password", siteID: "siteID")
        return instance
    }()
    
    let SourceName: String
    let Password: String
    let SiteID: String
        
    init(sourceName: String, password: String, siteID: String) {
        SourceName = sourceName
        Password = password
        SiteID = siteID
    }
}
