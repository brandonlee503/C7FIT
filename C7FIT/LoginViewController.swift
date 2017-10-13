//
//  LoginViewController.swift
//  C7FIT
//
//  Created by Brandon Lee on 1/23/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    // MARK: - Constants

    let firebaseDataManager = FirebaseDataManager()

    // MARK: - Properties

    var loginView = LoginView()

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"
        view.backgroundColor = .white
        loginView.loginButton.addTarget(self, action: #selector(self.loginPressed), for: .touchUpInside)
        loginView.createAccountButton.addTarget(self, action: #selector(self.createAccountPressed), for: .touchUpInside)
        loginView.cancelButton.addTarget(self, action: #selector(self.cancelButtonPressed), for: .touchUpInside)
        loginView.forgotPasswordButton.addTarget(self, action: #selector(self.forgotPasswordPressed), for: .touchUpInside)
        loginView.emailField.delegate = self
        loginView.passwordField.delegate = self
        view.addSubview(loginView)
        setupConstraints()
        view.setNeedsUpdateConstraints()
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

    func loginPressed() {
        firebaseDataManager.signIn(email: loginView.emailField.text!, password: loginView.passwordField.text!) { user, error in
            guard user != nil else { return self.displayError(error: error!) }
            self.dismiss(animated: true, completion: nil)
        }
    }

    func createAccountPressed() {
        let email = loginView.emailField.text
        let password = loginView.passwordField.text
        firebaseDataManager.createAccount(email: email!, password: password!) { user, error in
            guard user != nil else { return self.displayError(error: error!) }
            self.firebaseDataManager.signIn(email: email!, password: password!, completion: { user, error in
                guard let user = user else { return self.displayError(error: error!) }
                self.firebaseDataManager.buildUserProfile(uid: user.uid, email: self.loginView.emailField.text!)
                self.dismiss(animated: true, completion: nil)
            })
        }
    }

    func forgotPasswordPressed() {
        if let email = loginView.emailField.text, email.count > 0 {
            firebaseDataManager.sendPasswordResetEmail(email: email) { error in
                guard !(error != nil) else { return self.displayError(error: error!) }
                let confirmationAlert = UIAlertController(title: "Verification Email Sent",
                                                          message: "A verification email has been sent to your account to reset your password.",
                                                          preferredStyle: .alert)
                let submitAction = UIAlertAction(title: "Ok", style: .default)
                confirmationAlert.addAction(submitAction)
                self.present(confirmationAlert, animated: true, completion: nil)
            }
        } else {
            let missingEmailAlert = UIAlertController(title: "Missing field", message: "Please enter an email", preferredStyle: .alert)
            let submitAction = UIAlertAction(title: "Ok", style: .default)
            missingEmailAlert.addAction(submitAction)
            self.present(missingEmailAlert, animated: true, completion: nil)
        }
    }
    
    func cancelButtonPressed() {
        // Segue back to home screen
        self.presentingViewController?.childViewControllers[0].tabBarController?.selectedIndex = 0
        self.dismiss(animated: true, completion: nil)
    }

    func displayError(error: Error) {
        let errorAlert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let submitAction = UIAlertAction(title: "Ok", style: .default)
        errorAlert.addAction(submitAction)
        self.present(errorAlert, animated: true, completion: nil)
    }

    // MARK: - UITextFieldDelegate

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
