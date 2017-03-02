//
//  RunData.swift
//  C7FIT
//
//  Created by Michael Lee on 2/23/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import Foundation
import Firebase

struct RunData {
    var runTitle: String
    var time: Double
    var distance: Double
    var pace: String
    var locations: [Location]
//    let dateTime: NSDate
    
    init(){
        self.runTitle = "testing"
        self.time = 0.0
        self.distance = 0.0
        self.pace = ""
        self.locations = []
    }
    
    init(runTitle: String, time: Double, distance: Double, pace: String, locations: [Location], dateTime: NSDate) {
        self.runTitle = runTitle
        self.time = time
        self.distance = distance
        self.pace = pace
        self.locations = locations
//        self.dateTime = dateTime
    }
    
    func convertLocToString() -> [String] {
        var resultArr = [String]()
        for item in self.locations {
            var tempString = item.toJSON()
            resultArr.append(tempString)
        }
        return resultArr
    }
    
    func toAnyObject() -> Any {
        return [
            "runTitle": runTitle,
            "time": time.description,
            "distance": distance.description,
            "pace": pace,
            "locations": convertLocToString(),
//            dateTime: dateTime
        ]
    }
}
