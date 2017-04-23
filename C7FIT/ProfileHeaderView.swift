//
//  ProfileHeaderView.swift
//  C7FIT
//
//  Created by Brandon Lee on 1/24/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import UIKit

class ProfileHeaderView: UITableViewHeaderFooterView {

    // MARK: - Properties

    var profileImageView = CircularImageView()
    var updateProfileButton = UIButton()
    var nameField = UITextField()
    var bioField = UITextView()
    var placeholderLabel = UILabel()

    // MARK: - Initialization

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
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
        // TODO: Find if there's a better way to do this
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        let imageLeft = profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10)
        let imageTop = profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 20)
        let imageBottom = profileImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        let imageWidth = profileImageView.widthAnchor.constraint(equalToConstant: 110)
        imageLeft.priority = 999
        imageTop.priority = 999
        imageBottom.priority = 999
        imageWidth.priority = 999
        NSLayoutConstraint.activate([imageLeft, imageTop, imageBottom, imageWidth])

        updateProfileButton.translatesAutoresizingMaskIntoConstraints = false
        let buttonX = updateProfileButton.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor)
        let buttonY = updateProfileButton.topAnchor.constraint(equalTo: profileImageView.bottomAnchor)
        buttonX.priority = 999
        buttonY.priority = 999
        NSLayoutConstraint.activate([buttonX, buttonY])

        nameField.translatesAutoresizingMaskIntoConstraints = false
        let nameLeading = nameField.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10)
        let nameTop = nameField.topAnchor.constraint(equalTo: profileImageView.topAnchor, constant: 10)
        nameLeading.priority = 999
        nameTop.priority = 999
        NSLayoutConstraint.activate([nameLeading, nameTop])

        bioField.translatesAutoresizingMaskIntoConstraints = false
        let bioLeading = bioField.leadingAnchor.constraint(equalTo: nameField.leadingAnchor)
        let bioTrailing = bioField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        let bioTop = bioField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 10)
        let bioBottom = bioField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        bioLeading.priority = 999
        bioTrailing.priority = 999
        bioTop.priority = 999
        bioBottom.priority = 999
        NSLayoutConstraint.activate([bioLeading, bioTrailing, bioTop, bioBottom])
    }
}

// MARK: - UITextViewDelegate

extension ProfileHeaderView: UITextViewDelegate {

    // Clear placeholder text
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !bioField.text.isEmpty
    }
}
