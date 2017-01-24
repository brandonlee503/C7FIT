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

    var profileView = ProfileView()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 98/255, green: 65/255, blue: 133/255, alpha: 1)
        
        // Check if user is signed in
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
        // Dispose of any resources that can be recreated.
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
    
    func loginPressed() {
        let loginAlert = UIAlertController(title: "Login", message: nil, preferredStyle: .alert)
        let submitAction = UIAlertAction(title: "Submit", style: .default) { action in
            let emailField = loginAlert.textFields![0] as UITextField
            let passwordField = loginAlert.textFields![1] as UITextField
            FIRAuth.auth()!.signIn(withEmail: emailField.text!, password: passwordField.text!)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        loginAlert.addTextField { textEmail in
            textEmail.placeholder = "Email"
        }
        
        loginAlert.addTextField { textPassword in
            textPassword.isSecureTextEntry = true
            textPassword.placeholder = "Password"
        }
        
        loginAlert.addAction(submitAction)
        loginAlert.addAction(cancelAction)
        self.present(loginAlert, animated: true, completion: nil)
    }
    
    func logoutPressed() {
        do {
            try FIRAuth.auth()?.signOut()
        } catch let signoutError {
            print("Error signing out: \(signoutError.localizedDescription)")
        }
    }
    
    func createAccountPressed() {
        let createAccountAlert = UIAlertController(title: "Register", message: nil, preferredStyle: .alert)
        let submitAction = UIAlertAction(title: "Submit", style: .default) { action in
            let emailField = createAccountAlert.textFields![0] as UITextField
            let passwordField = createAccountAlert.textFields![1] as UITextField
            FIRAuth.auth()?.createUser(withEmail: emailField.text!, password: passwordField.text!) { user, error in
                if error == nil {
                    FIRAuth.auth()?.signIn(withEmail: emailField.text!, password: passwordField.text!)
                } else {
                    print("Create Account Error: \(error?.localizedDescription)")
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        createAccountAlert.addTextField { textEmail in
            textEmail.placeholder = "Email"
        }
        
        createAccountAlert.addTextField { textPassword in
            textPassword.isSecureTextEntry = true
            textPassword.placeholder = "Password"
        }
        
        createAccountAlert.addAction(submitAction)
        createAccountAlert.addAction(cancelAction)
        self.present(createAccountAlert, animated: true, completion: nil)
    }
}
