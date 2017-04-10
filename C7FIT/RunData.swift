//
//  RunData.swift
//  C7FIT
//
//  Created by Michael Lee on 2/23/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

// swiftlint:disable function_parameter_count

import Foundation
import Firebase
import HealthKit

struct RunData {
    var runTitle: String
    var time: Double
    var distance: Double
    var pace: String
    var locations: [Location]
    var date: Date

    init() {
        self.runTitle = "run"
        self.time = 0.0
        self.distance = 0.0
        self.pace = ""
        self.locations = []
        self.date = Date()
    }

    init(runTitle: String, time: Double, distance: Double, pace: String, locations: [Location], date: Date?) {
        self.runTitle = runTitle
        self.time = time
        self.distance = distance
        self.pace = pace
        self.locations = locations
        self.date = date ?? Date()
    }

    func dispTimePretty() -> String {
        let seconds = time
        let HourQuantity = HKQuantity(unit: HKUnit.hour(), doubleValue: floor(seconds/360))
        let minuteQuantity = HKQuantity(unit: HKUnit.minute(), doubleValue: floor(seconds/60))
        let secondsQuantity = HKQuantity(unit: HKUnit.second(), doubleValue: seconds.truncatingRemainder(dividingBy: 60.0))
        let prettyString = HourQuantity.description + " "  + minuteQuantity.description + " " + secondsQuantity.description

        return prettyString
    }

    static func dispTimePrettyColon(time: Double) -> String {
        let second = time
        let hour = floor(second/360)
        let minute = floor(second/60)
        let seconds = floor(second.truncatingRemainder(dividingBy: 60.0))
        return String(format:"%02i:%02i:%02i", Int(hour), Int(minute), Int(seconds))
    }

    func dispDistancePretty() -> String {
        let units = "m"
        let prettyString = distance.description + units
        return prettyString
    }

    func dispDatePretty() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        print("date")
        print(date)
        print("format")
        print(dateFormatter.string(from: date))
        return dateFormatter.string(from: date)
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
            "time": time,
            "distance": distance,
            "pace": pace,
            "locations": convertLocToString(),
            "date": date.timeIntervalSince1970
        ]
    }

    static func roundDouble(double: Double, round: Int) -> Double {
        // TODO: No other way to access decimal functions?
        let factor = pow(10, round) as NSDecimalNumber
        let result = (double * factor.doubleValue).rounded() / factor.doubleValue
        return result
    }
}
