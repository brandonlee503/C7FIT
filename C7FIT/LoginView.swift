//
//  LoginView.swift
//  C7FIT
//
//  Created by Brandon Lee on 1/23/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import UIKit

class LoginView: UIView {

    // MARK: - Properties

    var appLogo = UIImageView()
    var cancelButton = UIButton()
    var usernameField = UITextField()
    var passwordField = UITextField()
    var loginButton = UIButton()
    var createAccountButton = UIButton()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - Layout

    func setup() {
        backgroundColor = .orange

        appLogo.image = UIImage(named: "C7FITLogo")
        addSubview(appLogo)

        cancelButton.setImage(#imageLiteral(resourceName: "stop_2x"), for: .normal)
        cancelButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        addSubview(cancelButton)

        usernameField.placeholder = "Username"
        usernameField.font = UIFont.systemFont(ofSize: 14)
        usernameField.layer.borderColor = UIColor.black.cgColor
        usernameField.layer.borderWidth = 1
        usernameField.layer.cornerRadius = 5
        usernameField.backgroundColor = .white
        usernameField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0) // Text margin inset
        addSubview(usernameField)

        passwordField.placeholder = "Password"
        passwordField.font = UIFont.systemFont(ofSize: 14)
        passwordField.layer.borderColor = UIColor.black.cgColor
        passwordField.layer.borderWidth = 1
        passwordField.layer.cornerRadius = 5
        passwordField.backgroundColor = .white
        passwordField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
        addSubview(passwordField)

        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.backgroundColor = .black
        loginButton.layer.cornerRadius = 5
        addSubview(loginButton)

        createAccountButton.setTitle("Create Account", for: .normal)
        createAccountButton.setTitleColor(.white, for: .normal)
        createAccountButton.backgroundColor = .black
        createAccountButton.layer.cornerRadius = 5
        addSubview(createAccountButton)
    }

    func setupConstraints() {
        appLogo.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        usernameField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        createAccountButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            appLogo.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            appLogo.leftAnchor.constraint(equalTo: leftAnchor, constant: 50),
            appLogo.rightAnchor.constraint(equalTo: rightAnchor, constant: -50),
            appLogo.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -340)
        ])

        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            cancelButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 10)
        ])

        NSLayoutConstraint.activate([
            usernameField.topAnchor.constraint(equalTo: appLogo.bottomAnchor, constant: 30),
            usernameField.leftAnchor.constraint(equalTo: appLogo.leftAnchor, constant: 20),
            usernameField.rightAnchor.constraint(equalTo: appLogo.rightAnchor, constant: -20),
            usernameField.heightAnchor.constraint(equalToConstant: 30)
        ])

        NSLayoutConstraint.activate([
            passwordField.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 10),
            passwordField.leftAnchor.constraint(equalTo: usernameField.leftAnchor),
            passwordField.rightAnchor.constraint(equalTo: usernameField.rightAnchor),
            passwordField.heightAnchor.constraint(equalToConstant: 30)
        ])

        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 30),
            loginButton.leftAnchor.constraint(equalTo: passwordField.leftAnchor, constant: 40),
            loginButton.rightAnchor.constraint(equalTo: passwordField.rightAnchor, constant: -40)
        ])

        NSLayoutConstraint.activate([
            createAccountButton.centerXAnchor.constraint(equalTo: loginButton.centerXAnchor),
            createAccountButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10),
            createAccountButton.leftAnchor.constraint(equalTo: loginButton.leftAnchor),
            createAccountButton.rightAnchor.constraint(equalTo: loginButton.rightAnchor)
        ])
    }
}
