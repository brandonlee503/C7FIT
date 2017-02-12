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
         - Parameter completion: A callback that returns FIRAuthCallback
     */
    func createAccount(email: String, password: String, completion: @escaping (_: FIRUser?, _:Error?) -> Void) {
        FIRAuth.auth()?.createUser(withEmail: email, password: password) { user, error in
            completion(user, error)
        }
    }
    
    /**
         Submit login with credentials, display profile screen if valid.
         
         - Parameter email: User email string
         - Parameter password: User password string
         - Parameter completion: A callback that returns FIRAuthCallback
     */
    func signIn(email: String, password: String, completion: @escaping (_: FIRUser?, _: Error?) -> Void) {
        FIRAuth.auth()?.signIn(withEmail: email, password: password) { user, error in
            print("login screen user: \(user?.email)")
            completion(user, error)
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
        let newUser = User(email: email, photoURL: nil, name: nil, bio: nil, weight: nil, height: nil, bmi: nil, mileTime: nil, pushups: nil, situps: nil, legPress: nil, benchPress: nil, lateralPull: nil)
        let newUserRef = self.ref.child("users").child(uid)
        newUserRef.setValue(newUser.toAnyObject())
    }
    
    // MARK: - User State
    
    /**
        Fetch user from the database.
     
        - Parameter uid: User's universal ID
        - Parameter completion: A callback that returns a FIRDataSnapshot
     */
    func fetchUser(uid: String, completion: @escaping (_: FIRDataSnapshot) -> Void) {
        ref.child("users").child(uid).observeSingleEvent(of: .value, with: { snapshot in
            completion(snapshot)
        })
    }
    
    /**
        Monitor the login state of the user.
        
        - Parameter completion: A callback that returns FIRAuthStateDidChangeListenerHandle
     */
    func monitorLoginState(completion: @escaping (_: FIRAuth, _: FIRUser?) -> Void) {
        FIRAuth.auth()?.addStateDidChangeListener() { auth, user in
            completion(auth, user)
        }
    }
    
    // MARK: - Data Modification
    
    func updateUser(uid: String, user: User) {
        let newUserRef = self.ref.child("users").child(uid)
        newUserRef.setValue(user.toAnyObject())
    }
}
