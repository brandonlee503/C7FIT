//
//  ProfileView.swift
//  C7FIT
//
//  Created by Brandon Lee on 12/22/16.
//  Copyright © 2016 Brandon Lee. All rights reserved.
//

import UIKit

class ProfileView: UIView {
    
    var titleLabel: UILabel = UILabel()
    var logoutButton: UIButton = UIButton()

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
    
    func setup() {
        titleLabel.text = "Profile"
        addSubview(titleLabel)
    }
    
    func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        let centerTitleX = titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        let centerTitleY = titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        NSLayoutConstraint.activate([centerTitleX, centerTitleY])
    }
    
    func setupLogoutButton() {
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.setTitleColor(.black, for: .normal)
        addSubview(logoutButton)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        let logoutX = logoutButton.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor)
        let logoutY = logoutButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10)
        NSLayoutConstraint.activate([logoutX, logoutY])
    }
}
