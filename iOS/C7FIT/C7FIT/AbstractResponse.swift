//
//  AbstractResponse.swift
//  C7FIT
//
//  Created by Brandon Lee on 12/25/16.
//  Copyright © 2016 Brandon Lee. All rights reserved.
//

import Foundation

/**
    Abstract representation of responses from the MindBody API
 */
//protocol AbstractResponse : XMLParserDelegate {
//    
//    // XML Parsing
//    var element: String? { get }
//    var parentElementName: String? { get }
//    
//    // Response error code
//    var errorCode: Int? { get set }
//    // Response message
//    var message: String? { get set }
//    // Response status
//    var status: String? { get set }
//    // Total results in response
//    var resultCount: Int? { get set }
//    
//    // Mapping XML data
//    func mapData(data: NSData)
//}

/**
    Abstract representation of responses from the MindBody API
 */
class AbstractResponse {
    // XML Parsing
    var element: String?
    var parentElementName: String?
    
    // Response error code
    var errorCode: Int?
    // Response message
    var message: String?
    // Response status
    var status: String?
    // Total results in response
    var resultCount: Int?
    
    // Mapping XML data (Override this)
    func mapData(data: NSData) {
        
    }
}
