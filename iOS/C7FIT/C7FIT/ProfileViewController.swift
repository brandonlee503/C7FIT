//
//  ProfileViewController.swift
//  C7FIT
//
//  Created by Brandon Lee on 12/22/16.
//  Copyright © 2016 Brandon Lee. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    // MARK: - Properties
    
    var profileView = ProfileView()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.barTintColor = .orange
        
        // Monitor for user login/logout
        FIRAuth.auth()?.addStateDidChangeListener() { auth, user in
            if user != nil {
                print("User signed in")
                self.profileView.setupLogoutButton()
                self.profileView.logoutButton.addTarget(self, action: #selector(self.logoutPressed), for: .touchUpInside)
            } else {
                print("User not signed in")
                self.present(LoginViewController(), animated: true, completion:nil)
            }
        }

        self.view.addSubview(profileView)
        setupConstraints()
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
    
    // MARK: - User Interaction
        
    func logoutPressed() {
        do {
            try FIRAuth.auth()?.signOut()
        } catch let signoutError {
            print("Error signing out: \(signoutError.localizedDescription)")
        }
    }
}
