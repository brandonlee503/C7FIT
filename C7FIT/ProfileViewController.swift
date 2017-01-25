//
//  ProfileViewController.swift
//  C7FIT
//
//  Created by Brandon Lee on 12/22/16.
//  Copyright © 2016 Brandon Lee. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UITableViewController {

    // MARK: - Constants
    
    let ref = FIRDatabase.database().reference(withPath: "users")
    
    // MARK: - Properties
    
    var profileView = ProfileView()
    
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
        
        // Monitor for user login/logout
        FIRAuth.auth()?.addStateDidChangeListener() { auth, user in
            if user != nil {
                print("User signed in")
            } else {
                print("User not signed in")
                self.present(LoginViewController(), animated: true, completion:nil)
//                self.navigationController?.pushViewController(LoginViewController(), animated: true)
            }
        }
        
        self.view.setNeedsUpdateConstraints()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Layout
    
    func setupConstraints() {
        profileView.translatesAutoresizingMaskIntoConstraints = false
        let topView = profileView.topAnchor.constraint(equalTo: view.topAnchor)
        let bottomView = profileView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        let leftView = profileView.leftAnchor.constraint(equalTo: view.leftAnchor)
        let rightView = profileView.rightAnchor.constraint(equalTo: view.rightAnchor)
        NSLayoutConstraint.activate([topView, bottomView, leftView, rightView])
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
        print("update name lmao")
        
    }
    
    func logoutPressed() {
        do {
            try FIRAuth.auth()?.signOut()
        } catch let signoutError {
            print("Error signing out: \(signoutError.localizedDescription)")
        }
    }
}
