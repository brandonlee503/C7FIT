//
//  ProfileViewModel.swift
//  C7FIT
//
//  Created by Brandon Lee on 12/24/16.
//  Copyright © 2016 Brandon Lee. All rights reserved.
//

import Foundation

/**
    Base struct for formatting various data types
 */
struct ProfileViewModel {

    // Personal Weight Array
    static let personalWeight: Array = {
        (0...500).map {"\($0)"}
    }()

    // Imperial Height Array
    static let personalHeight: Array = {
        (12...96).map {
            ("\($0 / 12)' \($0 % 12)\"")
        }
    }()

    // Rep Array
    static let repetitions: Array = {
        (0...1000).map {"\($0)"}
    }()

    // Weight Array
    static let weights: Array = {
        stride(from: 0, to: 450, by: 5).map {"\($0)"}
    }()

    /**
        Build existing user from JSON snapshot data.
     
        - Parameter json: JSON Dictionary
        - Returns: User?
     */
    static func buildExistingUser(json: [String: AnyObject]) -> User? {
        guard let email = json["email"] as? String,
            let photoURL = json["photoURL"] as? String,
            let name = json["name"] as? String,
            let bio = json["bio"] as? String,
            let weight = json["weight"] as? String,
            let height = json["height"] as? String,
            let bmi = json["bmi"] as? String,
            let mileTime = json["mileTime"] as? String,
            let pushups = json["pushups"] as? String,
            let situps = json["situps"] as? String,
            let legPress = json["legPress"] as? String,
            let benchPress = json["benchPress"] as? String,
            let lateralPull = json["lateralPull"] as? String else { return nil }

            return User(email: email,
                        photoURL: photoURL,
                        name: name,
                        bio: bio,
                        weight: weight,
                        height: height,
                        bmi: bmi,
                        mileTime: mileTime,
                        pushups: pushups,
                        situps: situps,
                        legPress: legPress,
                        benchPress: benchPress,
                        lateralPull: lateralPull)
    }

    /**
        Calculate BMI from imperial units.
        http://extoxnet.orst.edu/faqs/dietcancer/web2/twohowto.html
     
        - Parameter weight: String in imperial units
        - Parameter height: String in imperial units
        - Returns: String
     */
    static func calculateBMI(weight: String, height: String) -> String? {
        guard weight != "", height != "" else { return nil }
        let metricWeight = Double(weight.intValue) * 0.45
        let parsedHeight = height.components(separatedBy: ["\'", " ", "\""])
        let metricHeight = Double(parsedHeight[0].intValue * 12 + parsedHeight[2].intValue) * 0.025
        let squaredHeight = pow(metricHeight, 2)
        return String(format: "%.2f", (metricWeight / squaredHeight))
    }
}
