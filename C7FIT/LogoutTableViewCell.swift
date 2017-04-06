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

    var logoutLabel: UILabel = UILabel()

    // MARK: - Initialization

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Layout

    func setup() {
        logoutLabel.text = "Logout"
        logoutLabel.textColor = .black
        addSubview(logoutLabel)
    }

    func setupConstraints() {
        logoutLabel.translatesAutoresizingMaskIntoConstraints = false
        let logoutX = logoutLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        let logoutY = logoutLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        NSLayoutConstraint.activate([logoutX, logoutY])
    }
}
