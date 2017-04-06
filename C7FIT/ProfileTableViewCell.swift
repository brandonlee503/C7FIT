//
//  ProfileTableViewCell.swift
//  C7FIT
//
//  Created by Brandon Lee on 1/24/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    // MARK: - Properties
    var profileImageView: CircularImageView = CircularImageView()
    var updateProfileButton: UIButton = UIButton()
    var nameField: UITextField = UITextField()
    var bioField: UITextView = UITextView()

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
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.masksToBounds = false
        profileImageView.layer.borderColor = UIColor.black.cgColor
        profileImageView.clipsToBounds = true
        profileImageView.backgroundColor = .green
        addSubview(profileImageView)

        updateProfileButton.setTitle("Update Picture", for: .normal)
        updateProfileButton.setTitleColor(.blue, for: .normal)
        updateProfileButton.titleLabel?.font = UIFont.systemFont(ofSize: 8)
        addSubview(updateProfileButton)

        nameField.backgroundColor = .cyan
        nameField.placeholder = "Add your name"
        addSubview(nameField)

        bioField.backgroundColor = .red
        bioField.text = "Add a bio"
        addSubview(bioField)
    }

    func setupConstraints() {
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        let imageLeft = profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10)
        let imageTop = profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 20)
        let imageBottom = profileImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        let imageWidth = profileImageView.widthAnchor.constraint(equalToConstant: 110)
        NSLayoutConstraint.activate([imageLeft, imageTop, imageBottom, imageWidth])

        updateProfileButton.translatesAutoresizingMaskIntoConstraints = false
        let buttonX = updateProfileButton.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor)
        let buttonY = updateProfileButton.topAnchor.constraint(equalTo: profileImageView.bottomAnchor)
        NSLayoutConstraint.activate([buttonX, buttonY])

        nameField.translatesAutoresizingMaskIntoConstraints = false
        let nameLeading = nameField.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10)
        let nameTop = nameField.topAnchor.constraint(equalTo: profileImageView.topAnchor, constant: 10)
        NSLayoutConstraint.activate([nameLeading, nameTop])

        bioField.translatesAutoresizingMaskIntoConstraints = false
        let bioLeading = bioField.leadingAnchor.constraint(equalTo: nameField.leadingAnchor)
        let bioTrailing = bioField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        let bioTop = bioField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 10)
        let bioBottom = bioField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        NSLayoutConstraint.activate([bioLeading, bioTrailing, bioTop, bioBottom])
    }
}
