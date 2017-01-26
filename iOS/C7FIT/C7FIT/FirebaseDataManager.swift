//
//  FirebaseDataManager.swift
//  C7FIT
//
//  Created by Brandon Lee on 1/25/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import Foundation
import Firebase

/**
    A representation of C7FIT's Firebase services.
 */
struct FirebaseDataManager {
    
    // MARK: - Constants
    
    let ref = FIRDatabase.database().reference()
    
    // MARK: - User Account Login/Logout
    
    /**
        Create new user account with credentials.
     
         - Parameter email: User email string
         - Parameter password: User password string
         - Parameter completion: A callback that returns a bool
         - Returns: Request
     */
    func createAccount(email: String, password: String, completion: @escaping (_: Bool) -> Void) {
        var isSuccessful: Bool? = nil
        FIRAuth.auth()?.createUser(withEmail: email, password: password) { user, error in
            if error == nil {
                isSuccessful = true
            } else {
                isSuccessful = false
                print("Create Account Error: \(error?.localizedDescription)")
            }
            
            completion(isSuccessful!)
        }
    }
    
    /**
         Submit login with credentials, display profile screen if valid.
         
         - Parameter email: User email string
         - Parameter password: User password string
         - Parameter completion: A callback that returns a bool
         - Returns: Request.
     */
    func signIn(email: String, password: String, completion: @escaping (_: Bool, _: String?) -> Void) {
        var isSuccessful: Bool? = nil
        FIRAuth.auth()?.signIn(withEmail: email, password: password) { user, error in
            print("login screen user: \(user?.email)")
            if error == nil {
                isSuccessful = true
            } else {
                isSuccessful = false
                print("Login Error: \(error?.localizedDescription)")
            }
            
            completion(isSuccessful!, user?.uid)
        }
    }
    
    /**
        Log user out of Firebase account.
     */
    func logout() {
        do {
            try FIRAuth.auth()?.signOut()
        } catch let signoutError {
            print("Error signing out: \(signoutError.localizedDescription)")
        }
    }
    
    
    // MARK: - User Initialization
    
    /**
        Build up a new user profile in Firebase database after account authentication.
     
        - Parameter uid: User's universal ID
        - Parameter email: User email string
     */
    func buildUserProfile(uid: String, email: String) {
        let newUser = User(email: email, photoURL: nil, name: nil, weight: nil, height: nil, bmi: nil, mileTime: nil, pushups: nil, situps: nil, legPress: nil, benchPress: nil, lateralPull: nil)
        let newUserRef = self.ref.child("users").child(uid)
        newUserRef.setValue(newUser.toAnyObject())
    }
    
    // MARK: - User State
    
    /**
        Check if user has existing data in Firebase Database.
     
        - Parameter uid: User's universal ID
        - Parameter completion: A callback that returns a Bool
        - Returns: Request
     */
    func userExists(uid: String, completion: @escaping (_: Bool) -> Void) {
        var accountExists: Bool? = nil
        ref.child("users").observeSingleEvent(of: .value, with: { snapshot in
            if snapshot.hasChild(uid) {
                print("child exists")
                accountExists = true
            } else {
                print("child doesnt exist")
                accountExists = false
            }
            
            completion(accountExists!)
        })
    }
    
    /**
        Monitor the login state of the user.
        
        - Parameter completion: A callback that returns a Bool
        - Returns: Request
     */
    func monitorLoginState(completion: @escaping (_: Bool) -> Void) {
        var isLoggedIn: Bool? = nil
        FIRAuth.auth()?.addStateDidChangeListener() { auth, user in
            if user != nil {
                print("User \(user?.email) signed in")
                isLoggedIn = true
            } else {
                print("User not signed in")
                isLoggedIn = false
            }
            
            completion(isLoggedIn!)
        }
    }
}
