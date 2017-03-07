//
//  LocationData.swift
//  C7FIT
//
//  Created by Michael Lee on 2/23/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import Foundation
import MapKit

struct Location {
    var timestamp: String
    var latitude: Double
    var longitude: Double
    
    init() {
        self.timestamp = ""
        self.latitude = 0.0
        self.longitude = 0.0
    }
    
    init(timestamp: String, latitude: Double, longitude: Double) {
        self.timestamp = timestamp
        self.latitude = latitude
        self.longitude = longitude
    }
    
//    func toJSON() -> String {
//        let props = ["timestamp": self.timestamp, "latitude": self.latitude.description, "longitude": self.longitude.description]
//        do {
//            let jsonData = try JSONSerialization.data(withJSONObject: props,
//                                                                      options: .prettyPrinted)
//            return String(data: jsonData, encoding: String.Encoding.utf8)!
//        } catch let error {
//            print("error converting to json: \(error)")
//            return ""
//        }
//    }
//    
    
    func toAnyObject() -> Any {
        return [
            "timestamp": timestamp,
            "latitude": latitude.description,
            "longitude": longitude.description
        ]
    }
}

