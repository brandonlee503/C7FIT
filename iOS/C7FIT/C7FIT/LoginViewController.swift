//
//  LoginViewController.swift
//  C7FIT
//
//  Created by Brandon Lee on 1/23/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    var loginView = LoginView()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Login"
        self.view.backgroundColor = .white
        
        self.loginView.loginButton.addTarget(self, action: #selector(self.loginPressed), for: .touchUpInside)
        self.loginView.createAccountButton.addTarget(self, action: #selector(self.createAccountPressed), for: .touchUpInside)
        
        self.view.addSubview(loginView)
        setupConstraints()
        self.view.setNeedsUpdateConstraints()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Layout
    
    func setupConstraints() {
        loginView.translatesAutoresizingMaskIntoConstraints = false
        let topView = loginView.topAnchor.constraint(equalTo: view.topAnchor)
        let bottomView = loginView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        let leftView = loginView.leftAnchor.constraint(equalTo: view.leftAnchor)
        let rightView = loginView.rightAnchor.constraint(equalTo: view.rightAnchor)
        NSLayoutConstraint.activate([topView, bottomView, leftView, rightView])
    }
    
    // MARK: - User Interaction
    
    // TODO: Following two functions have a lot of duplicate code
    func loginPressed() {
        let loginAlert = UIAlertController(title: "Login", message: nil, preferredStyle: .alert)
        let submitAction = UIAlertAction(title: "Submit", style: .default) { action in
            let emailField = loginAlert.textFields![0] as UITextField
            let passwordField = loginAlert.textFields![1] as UITextField
            FIRAuth.auth()?.signIn(withEmail: emailField.text!, password: passwordField.text!) { _,_ in
                self.dismiss(animated: true, completion: nil)
            }
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

    func createAccountPressed() {
        let createAccountAlert = UIAlertController(title: "Register", message: nil, preferredStyle: .alert)
        let submitAction = UIAlertAction(title: "Submit", style: .default) { action in
            let emailField = createAccountAlert.textFields![0] as UITextField
            let passwordField = createAccountAlert.textFields![1] as UITextField
            FIRAuth.auth()?.createUser(withEmail: emailField.text!, password: passwordField.text!) { user, error in
                if error == nil {
                    FIRAuth.auth()?.signIn(withEmail: emailField.text!, password: passwordField.text!) { _,_ in
                        self.dismiss(animated: true, completion: nil)
                    }
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
