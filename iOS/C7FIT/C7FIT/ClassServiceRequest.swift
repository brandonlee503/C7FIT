//
//  ClassServiceRequest.swift
//  C7FIT
//
//  Created by Brandon Lee on 12/24/16.
//  Copyright © 2016 Brandon Lee. All rights reserved.
//

import Foundation

struct ClassServiceRequest {
    
    func getClasses(classIDs: Array<Any>?, staffIDs: Array<Any>?, startDateTime: Date?, endDateTime: Date?, clientID: String?, programIDs: Array<Any>?, sessionTypeIDs: Array<Any>?, locationIDs: Array<Any>?, schedulingWindow: Bool?) -> URLRequest {
        
        // Init request with header
        var requestString = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns=\"http://"
        "clients.mindbodyonline.com/api/0_5\">"
        "<soapenv:Header/>"
        "<soapenv:Body>"
        "<GetClasses>"
        "<Request>"
        
        // Source Credentials
        requestString += "<SourceCredentials>"
        requestString += "<SourceName>\(SourceCredentials.sharedInstance.SourceName)</SourceName>"
        requestString += "<Password>\(SourceCredentials.sharedInstance.Password)</Password>"
        requestString += "<SiteIDs><int>\(SourceCredentials.sharedInstance.SiteID)</int></SiteIDs>"
        requestString += "</SourceCredentials>"
        
        // User Credentials
        if let username = UserCredentials.sharedInstance.Username, let password = UserCredentials.sharedInstance.Password, let siteID = UserCredentials.sharedInstance.SiteID {
            requestString += "<UserCredentials>"
            requestString += "<Username>\(username)</Username>"
            requestString += "<Password>\(password)</Password>"
            requestString += "<SiteIDs><int>\(siteID)</int></SiteIDs>"
            requestString += "</UserCredentials>"
        }
        
        // ID Parameters
        if let classIDs = classIDs {
            requestString += "<ClassIDs>"
            for id in classIDs {
                requestString += "<int>\(id)</int>"
            }
            requestString += "</ClassIDs>"
        }
        
        if let staffIDs = staffIDs {
            requestString += "<StaffIDs>"
            for id in staffIDs {
                requestString += "<long>\(id)</long>"
            }
            requestString += "</StaffIDs>"
        }
        
        if let programIDs = programIDs {
            requestString += "<ProgramIDs>"
            for id in programIDs {
                requestString += "<int>\(id)</int>"
            }
            requestString += "</ProgramIDs>"
        }
        
        if let sessionTypeIDs = sessionTypeIDs {
            requestString += "<SessionTypeIDs>"
            for id in sessionTypeIDs {
                requestString += "<int>\(id)</int>"
            }
            requestString += "</SessionTypeIDs>"
        }
        
        if let locationIDs = locationIDs {
            requestString += "<LocationIDs>"
            for id in locationIDs {
                requestString += "<int>\(id))</int>"
            }
            requestString += "</LocationIDs>"
        }
        
        // Dates (if null, just pulls today's classes)
        if let startDateTime = startDateTime, let endDateTime = endDateTime {
            requestString += "<StartDateTime>\(DataFormatter.formatISOfromDate(date: startDateTime))</StartDateTime>"
            requestString += "<EndDateTime>\(DataFormatter.formatISOfromDate(date: endDateTime))</EndDateTime>"
        }
        
        if let clientID = clientID {
            requestString += "<ClientID>\(clientID)</ClientID>"
        }
        
        requestString += "<SchedulingWindow>\(clientID != nil ? String(describing: clientID) : "false")</SchedulingWindow>"
        requestString += "<XMLDetail>Full</XMLDetail>"
        requestString += "</Request></GetClasses></soapenv:Body></soapenv:Envelope>"
        
        // Build request
        let url = URL(string: MindBodyConstants.ClassService)
        var request = URLRequest(url: url!)
        request.addValue(MindBodyConstants.ContentType, forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = requestString.data(using: .utf8)
        return request
    }
}
