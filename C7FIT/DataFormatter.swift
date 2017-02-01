//
//  DataFormatter.swift
//  C7FIT
//
//  Created by Brandon Lee on 12/24/16.
//  Copyright © 2016 Brandon Lee. All rights reserved.
//

import Foundation

/**
    Base for formatting various data types
 */
struct DataFormatter {
    
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
            let weight = json["weight"] as? Int,
            let height = json["height"] as? Int,
            let bmi = json["bmi"] as? Double,
            let mileTime = json["mileTime"] as? TimeInterval,
            let pushups = json["pushups"] as? Int,
            let situps = json["situps"] as? Int,
            let legPress = json["legPress"] as? Int,
            let benchPress = json["benchPress"] as? Int,
            let lateralPull = json["lateralPull"] as? Int else { return nil }
        
            return User(email: email, photoURL: photoURL, name: name, bio: bio, weight: weight, height: height, bmi: bmi, mileTime: mileTime, pushups: pushups, situps: situps, legPress: legPress, benchPress: benchPress, lateralPull: lateralPull)
    }
}
