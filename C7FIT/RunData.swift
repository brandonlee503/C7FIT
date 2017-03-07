//
//  RunData.swift
//  C7FIT
//
//  Created by Michael Lee on 2/23/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import Foundation
import Firebase
import HealthKit

struct RunData {
    var runTitle: String
    var time: Double
    var distance: Double
    var pace: String
    var locations: [Location]
//    let dateTime: NSDate
    
    init() {
        self.runTitle = "testing1"
        self.time = 0.0
        self.distance = 0.0
        self.pace = ""
        self.locations = []
    }
    
    init(runTitle: String, time: Double, distance: Double, pace: String, locations: [Location]) {
        self.runTitle = runTitle
        self.time = time
        self.distance = distance
        self.pace = pace
        self.locations = locations
//        self.dateTime = dateTime
    }
    
    func dispTimePretty() -> String {
        let seconds = time
        let HourQuantity = HKQuantity(unit: HKUnit.hour(), doubleValue: floor(seconds/360))
        let minuteQuantity = HKQuantity(unit: HKUnit.minute(), doubleValue: floor(seconds/60))
        let secondsQuantity = HKQuantity(unit: HKUnit.second(), doubleValue: seconds.truncatingRemainder(dividingBy: 60.0))
        let prettyString = "Time Elapsed: " + HourQuantity.description + " "  + minuteQuantity.description + " " + secondsQuantity.description
        
        return prettyString
    }
    
    func convertLocToString() -> [Any] {
        var resultArr = [Any]()
        for item in self.locations {
            resultArr.append(item.toAnyObject())
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
