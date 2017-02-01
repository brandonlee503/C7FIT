//
//  ProfileViewController.swift
//  C7FIT
//
//  Created by Brandon Lee on 12/22/16.
//  Copyright © 2016 Brandon Lee. All rights reserved.
//

import UIKit

class ProfileViewController: UITableViewController, UITextViewDelegate {

    // MARK: - Constants
    
    let firebaseDataManager: FirebaseDataManager = FirebaseDataManager()
    
    // MARK: - Properties
    
    var userID: String?
    var user: User?
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.barTintColor = .orange
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: "ProfileCell")
        tableView.register(LogoutTableViewCell.self, forCellReuseIdentifier: "LogoutCell")
        
        // Monitor for user login/logout state
        firebaseDataManager.monitorLoginState() { auth, user in
            
            // If user is signed in, set userID else display login screen
            guard let userID = user?.uid else { return self.present(LoginViewController(), animated: true, completion:nil) }
            self.userID = userID
            
            // Create and build existing user
            self.firebaseDataManager.fetchUser(uid: userID) { data in
                // TODO: Create asynchronous error handling protocols
                guard let json = data.value as? [String: AnyObject] else { return }
                self.user = DataFormatter.buildExistingUser(json: json)
                self.tableView.reloadData()
            }
        }
        
        self.view.setNeedsUpdateConstraints()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: UITableView Delegate and Datasource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 11
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row < 1 {
            return 150
        } else {
            return 50
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            if let cell: ProfileTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell") as? ProfileTableViewCell {
                cell.nameField.text = user?.name ?? ""
                cell.bioField.text = user?.bio ?? "Add a bio"
                // FIXME: Might need to update the control event
                cell.nameField.addTarget(self, action: #selector(self.nameFieldDidChange(_:)), for: .editingDidEnd)
                cell.bioField.delegate = self
                return cell
            }
        }
        
        if indexPath.row == 10 {
            if let cell: LogoutTableViewCell = tableView.dequeueReusableCell(withIdentifier: "LogoutCell") as? LogoutTableViewCell {
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Logout user
        if indexPath.row == 10 {
            logoutPressed()
        }
    }
    
    // MARK: - UITextView Delegate
    
    func textViewDidEndEditing(_ textView: UITextView) {
        print("update bio")
        guard let newBio = textView.text, let userID = self.userID else { return }
        firebaseDataManager.updateUserAttribute(uid: userID, key: "bio", value: newBio)
    }
    
    // MARK: - User Interaction
    
    func nameFieldDidChange(_ sender: UITextField) {
        print("update name")
        guard let newName = sender.text, let userID = self.userID else { return }
        firebaseDataManager.updateUserAttribute(uid: userID, key: "name", value: newName)
    }
    
    func logoutPressed() {
        firebaseDataManager.logout()
    }
}
