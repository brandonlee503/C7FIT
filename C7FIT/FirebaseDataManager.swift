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

    // MARK: - Static Information

    /**
        Fetch trainers and daily content data for homescreen
     
         - Returns completion: A callback that returns a FIRDataSnapshot
     */
    func fetchHomeScreenInfo(completion: @escaping (_: FIRDataSnapshot) -> Void) {
        ref.child("homescreen").observeSingleEvent(of: .value) { snapshot in
            completion(snapshot)
        }
    }

    /**
        Fetch club information

        - Returns completion: A callback that returns a FIRDataSnapshot
     */
    func fetchClubInfo(completion: @escaping (_: FIRDataSnapshot) -> Void) {
        ref.child("clubInfo").observeSingleEvent(of: .value, with: { snapshot in
            completion(snapshot)
        })
    }

    // MARK: - User Account Login/Logout

    /**
        Create new user account with credentials.
     
         - Parameter email: User email string
         - Parameter password: User password string
         - Returns completion: A callback that returns FIRAuthCallback
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
         - Returns completion: A callback that returns FIRAuthCallback
     */
    func signIn(email: String, password: String, completion: @escaping (_: FIRUser?, _: Error?) -> Void) {
        FIRAuth.auth()?.signIn(withEmail: email, password: password) { user, error in
            print("login screen user: \(String(describing: user?.email))")
            completion(user, error)
        }
    }

    /**
         Submit password reset with credentials.
     
         - Parameter email: User email string
         - Returns completion: A callback that returns FIRAuthCallback
     */
    func sendPasswordResetEmail(email: String, completion: @escaping (_:Error?) -> Void) {
        FIRAuth.auth()?.sendPasswordReset(withEmail: email, completion: { error in
            completion(error)
        })
    }
    
    /**
        Checks if the user is currently logged in.
     
        - Returns bool: A bool that represents if the user is logged in
     */
    func isLoggedInUser() -> Bool {
        return FIRAuth.auth()?.currentUser != nil
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
        let newUser = User(email: email,
                           photoURL: nil,
                           name: nil,
                           bio: nil,
                           weight: nil,
                           height: nil,
                           bmi: nil,
                           mileTime: nil,
                           pushups: nil,
                           situps: nil,
                           legPress: nil,
                           benchPress: nil,
                           lateralPull: nil)
        let newUserRef = self.ref.child("users").child(uid)
        newUserRef.setValue(newUser.toAnyObject())
    }

    // MARK: - User State

    /**
        Fetch user from the database.
     
        - Parameter uid: User's universal ID
        - Returns completion: A callback that returns a FIRDataSnapshot
     */
    func fetchUser(uid: String, completion: @escaping (_: FIRDataSnapshot) -> Void) {
        ref.child("users").child(uid).observeSingleEvent(of: .value, with: { snapshot in
            completion(snapshot)
        })
    }

    /**
     fetch user runs
    */
    func fetchUserRun(uid: String, runTitle: String, completion: @escaping (_: FIRDataSnapshot) -> Void) {
        ref.child("userRun").child(uid).child(runTitle).observeSingleEvent(of: .value, with: { snapshot in
            completion(snapshot)
        })
    }

    /**
     fetch list of user runs
    */
    func fetchUserRunList(uid: String, completion: @escaping (_: FIRDataSnapshot) -> Void) {
        ref.child("userRun").child(uid).observeSingleEvent(of: .value, with: { snapshot in
            completion(snapshot)
        })
    }
    /**
        Monitor the login state of the user.
        
        - Returns completion: A callback that returns FIRAuthStateDidChangeListenerHandle
     */
    func monitorLoginState(completion: @escaping (_: FIRAuth, _: FIRUser?) -> Void) {
        FIRAuth.auth()?.addStateDidChangeListener { auth, user in
            completion(auth, user)
        }
    }

    // MARK: - Data Modification

    /**
        Updates any new attributes of a given existing user
     
        - Parameter uid: User's universal ID
        - Parameter user: User data to update
     */
    func updateUser(uid: String, user: User) {
        let newUserRef = self.ref.child("users").child(uid)
        newUserRef.setValue(user.toAnyObject())
    }

    /**
        Updates any new attributes of a given user's run
    */
    func updateUserRun(uid: String, runTitle: String, userRun: RunData) {
        let newUserRun = self.ref.child("userRun").child(uid).child(runTitle)
        newUserRun.setValue(userRun.toAnyObject())
    }

    /**
        Uploads new profile picture to Firebase Storage
     
        - Parameter uid: User's universal ID
        - Parameter data: Image data to upload
        - Returns completion: A callback that returns a URL?
     */
    func uploadProfilePicture(uid: String, data: Data, completion: @escaping (_: URL?) -> Void) {
        let storageRef = FIRStorage.storage().reference(withPath: "profilePics/\(uid).jpg")
        let uploadMetaData = FIRStorageMetadata()
        uploadMetaData.contentType = "image/jpeg"
        storageRef.put(data, metadata: uploadMetaData) { (metaData, error) in
            if error == nil {
                // Update user profilePicURL
                completion(metaData?.downloadURL())
            } else {
                print("Upload profile pic error: \(String(describing: error?.localizedDescription))")
                completion(nil)
            }
        }
    }

    /**
        Helper function to build runData from JSON, after retrived from fireBase Db
    */
    func buildRunFromJson(json: [String: AnyObject]) -> RunData? {
        guard let runTitle = json["runTitle"] as? String,
            let time = ((json["time"] as? Double)),
            let distance = ((json["distance"] as? Double)),
            let pace = json["pace"] as? String,
            let locationsString = json["locations"] as? [AnyObject],
            let dateDouble = json["date"] as? Double else { return nil }

        var convertedLoc = [Location]()
        for locString in locationsString {
            if let tempLocation = self.buildLocFromJson(json: locString as! [String : AnyObject]) {
                convertedLoc.append(tempLocation)
            }
        }

        let date = Date(timeIntervalSince1970: dateDouble)

        return RunData(runTitle: runTitle, time: time, distance: distance, pace: pace, locations: convertedLoc, date: date)
    }

    /**
        Helper function to build location data from JSON, after retrieved from fireBase Db
    */
    func buildLocFromJson(json: [String: AnyObject]) -> Location? {
        guard let timestamp = json["timestamp"] as? String,
            let latitude = (json["latitude"] as? Double),
            let longitude = (json["longitude"] as? Double) else { return nil }
        return Location(timestamp: timestamp, latitude: latitude, longitude: longitude)
    }

}
