//
//  ProfileViewController.swift
//  C7FIT
//
//  Created by Brandon Lee on 12/22/16.
//  Copyright © 2016 Brandon Lee. All rights reserved.
//

import UIKit

class ProfileViewController: UITableViewController {

    // MARK: - Constants
    
    let firebaseDataManager: FirebaseDataManager = FirebaseDataManager()
    
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
        firebaseDataManager.monitorLoginState() { isLoggedIn in
            if !isLoggedIn {
                print("not logged in vc")
                self.present(LoginViewController(), animated: true, completion:nil)
            } else {
                print("is logged in vc")
            }
        }
        
        // Find user if existing, if not create one
        firebaseDataManager.userExists(uid: "testUID") { result in
            if result {
                print("user exists vc")
            } else {
                print("user doesnt exist vc")
                
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
                // FIXME: Might need to update the control event
                cell.nameField.addTarget(self, action: #selector(self.nameFieldDidChange), for: .editingDidEnd)
                return cell
            }
        }
        
        if indexPath.row == 10 {
            if let cell: LogoutTableViewCell = tableView.dequeueReusableCell(withIdentifier: "LogoutCell") as? LogoutTableViewCell {
                cell.logoutButton.addTarget(self, action: #selector(self.logoutPressed), for: .touchUpInside)
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    // MARK: - User Interaction
    
    func nameFieldDidChange() {
        print("update name")
        
    }
    
    func logoutPressed() {
        firebaseDataManager.logout()
    }
}
