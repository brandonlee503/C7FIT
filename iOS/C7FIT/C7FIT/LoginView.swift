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

    var loginButton: UIButton = UIButton()
    var createAccountButton: UIButton = UIButton()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        setupConstraints()
    }
    
    // MARK: - Layout

    func setup() {
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.black, for: .normal)
        addSubview(loginButton)
        
        createAccountButton.setTitle("Create Account", for: .normal)
        createAccountButton.setTitleColor(.black, for: .normal)
        addSubview(createAccountButton)
    }
    
    func setupConstraints() {
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        let loginX = loginButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        let loginY = loginButton.topAnchor.constraint(equalTo: centerYAnchor)
        NSLayoutConstraint.activate([loginX, loginY])
        
        createAccountButton.translatesAutoresizingMaskIntoConstraints = false
        let createX = createAccountButton.centerXAnchor.constraint(equalTo: loginButton.centerXAnchor)
        let createY = createAccountButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10)
        NSLayoutConstraint.activate([createX, createY])
    }
}
