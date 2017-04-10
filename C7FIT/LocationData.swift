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

    func toAnyObject() -> Any {
        return [
            "timestamp": timestamp,
            "latitude": latitude,
            "longitude": longitude
        ]
    }
}
