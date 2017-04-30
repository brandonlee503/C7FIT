//
//  ClubBioCell.swift
//  C7FIT
//
//  Created by Michael Lee on 2/1/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import UIKit

class ClubBioCell: UITableViewCell {

    // MARK: - Properties

    let bioTitle = UILabel()
    let bioDescription = UILabel()

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
        bioTitle.text = "Club Bio"
        bioTitle.textAlignment = .center
        addSubview(bioTitle)

        bioDescription.numberOfLines = 0
        bioDescription.lineBreakMode = .byWordWrapping
        bioDescription.textAlignment = .center
        addSubview(bioDescription)
    }

    func setupConstraints() {
        bioTitle.translatesAutoresizingMaskIntoConstraints = false
        bioDescription.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            bioTitle.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            bioTitle.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            bioTitle.topAnchor.constraint(equalTo: topAnchor, constant: 10)
        ])

        NSLayoutConstraint.activate([
            bioDescription.leftAnchor.constraint(equalTo: bioTitle.leftAnchor),
            bioDescription.rightAnchor.constraint(equalTo: bioTitle.rightAnchor),
            bioDescription.topAnchor.constraint(equalTo: bioTitle.bottomAnchor, constant: 10)
        ])
    }
}
