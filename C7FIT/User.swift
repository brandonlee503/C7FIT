//
//  User.swift
//  C7FIT
//
//  Created by Brandon Lee on 1/21/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import Foundation
import Firebase

/**
    A model representation of a User
 */
struct User {
    let email: String
    let photoURL: String?
    let name: String?
    let bio: String?
    let weight: String?
    let height: String?
    let bmi: String?
    let mileTime: String?
    let pushups: String?
    let situps: String?
    let legPress: String?
    let benchPress: String?
    let lateralPull: String?
    
    init(email: String, photoURL: String?, name: String?, bio: String?, weight: String?, height: String?, bmi: String?, mileTime: String?, pushups: String?, situps: String?, legPress: String?, benchPress: String?, lateralPull: String?) {
        self.email = email
        self.photoURL = photoURL
        self.name = name
        self.bio = bio
        self.weight = weight
        self.height = height
        self.bmi = bmi
        self.mileTime = mileTime
        self.pushups = pushups
        self.situps = situps
        self.legPress = legPress
        self.benchPress = benchPress
        self.lateralPull = lateralPull
    }
    
    func toAnyObject() -> Any {
        return [
            "email": email,
            "photoURL": photoURL ?? "",
            "name": name ?? "",
            "bio": bio ?? "",
            "weight": weight ?? "",
            "height": height ?? "",
            "bmi": bmi ?? "",
            "mileTime": mileTime ?? "",
            "pushups": pushups ?? "",
            "situps": situps ?? "",
            "legPress": legPress ?? "",
            "benchPress": benchPress ?? "",
            "lateralPull": lateralPull ?? ""
        ]
    }
}
