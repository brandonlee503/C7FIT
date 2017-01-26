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
    let weight: Int?
    let height: Int?
    let bmi: Double?
    let mileTime: TimeInterval?
    let pushups: Int?
    let situps: Int?
    let legPress: Int?
    let benchPress: Int?
    let lateralPull: Int?
    
    init(email: String, photoURL: String?, name: String?, weight: Int?, height: Int?, bmi: Double?, mileTime: TimeInterval?, pushups: Int?, situps: Int?, legPress: Int?, benchPress: Int?, lateralPull: Int?) {
        self.email = email
        self.photoURL = photoURL
        self.name = name
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
            "weight": weight ?? 0,
            "height": height ?? 0,
            "bmi": bmi ?? 0,
            "mileTime": mileTime ?? 0.0,
            "pushups": pushups ?? 0,
            "situps": situps ?? 0,
            "legPress": legPress ?? 0,
            "benchPress": benchPress ?? 0,
            "lateralPull": lateralPull ?? 0
        ]
    }
}
