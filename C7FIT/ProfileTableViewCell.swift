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
    var profileImageView = CircularImageView()
    var updateProfileButton = UIButton()
    var nameField = UITextField()
    var bioField = UITextView()
    var placeholderLabel = UILabel()

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
        updateProfileButton.titleLabel?.font = .italicSystemFont(ofSize: 8)
        addSubview(updateProfileButton)

        nameField.placeholder = "Add your name"
        nameField.font = UIFont.systemFont(ofSize: 14)
        addSubview(nameField)

        placeholderLabel.text = "Add a bio"
        placeholderLabel.font = UIFont.italicSystemFont(ofSize: 10)
        placeholderLabel.sizeToFit()
        placeholderLabel.textColor = .lightGray
        placeholderLabel.isHidden = !bioField.text.isEmpty
        bioField.addSubview(placeholderLabel)

        bioField.delegate = self
        bioField.layer.masksToBounds = false
        bioField.layer.borderWidth = 1
        bioField.layer.cornerRadius = 5
        bioField.layer.borderColor = UIColor.lightGray.cgColor
        bioField.font = UIFont.systemFont(ofSize: 10)
        addSubview(bioField)
    }

    func setupConstraints() {
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        updateProfileButton.translatesAutoresizingMaskIntoConstraints = false
        nameField.translatesAutoresizingMaskIntoConstraints = false
        bioField.translatesAutoresizingMaskIntoConstraints = false
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            profileImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            profileImageView.widthAnchor.constraint(equalToConstant: 110)
        ])

        NSLayoutConstraint.activate([
            updateProfileButton.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor),
            updateProfileButton.topAnchor.constraint(equalTo: profileImageView.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            nameField.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10),
            nameField.topAnchor.constraint(equalTo: profileImageView.topAnchor, constant: 10)
        ])

        NSLayoutConstraint.activate([
            bioField.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            bioField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            bioField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 10),
            bioField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])

        NSLayoutConstraint.activate([
            placeholderLabel.leftAnchor.constraint(equalTo: bioField.leftAnchor, constant: 5),
            placeholderLabel.topAnchor.constraint(equalTo: bioField.topAnchor, constant: 7)
        ])
    }
}

extension ProfileTableViewCell: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !bioField.text.isEmpty
    }
}
