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
    let uid: String
    let email: String
//    let weight: Int?
//    let height: Int?
//    let bmi: Double?
//    let mileTime: String?

    init(authData: FIRUser) {
        uid = authData.uid
        email = authData.email!
    }
    
    init(uid: String, email: String) {
        self.uid = uid
        self.email = email
    }
}
