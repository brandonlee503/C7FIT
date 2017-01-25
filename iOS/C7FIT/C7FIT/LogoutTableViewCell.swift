//
//  LogoutTableViewCell.swift
//  C7FIT
//
//  Created by Brandon Lee on 1/24/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import UIKit

class LogoutTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    var logoutButton: UIButton = UIButton()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        print("cell lmao")
        setup()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    func setup() {
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.setTitleColor(.black, for: .normal)
        addSubview(logoutButton)
    }
    
    func setupConstraints() {
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        let logoutX = logoutButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        let logoutY = logoutButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        NSLayoutConstraint.activate([logoutX, logoutY])
    }
}
