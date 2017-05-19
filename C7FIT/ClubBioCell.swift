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

    let cardView = UIView()
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
        backgroundColor = .clear

        cardView.backgroundColor = .white
        contentView.addSubview(cardView)
        contentView.sendSubview(toBack: cardView)

        bioTitle.text = "Club Bio"
        bioTitle.textAlignment = .center
        addSubview(bioTitle)

        bioDescription.font = UIFont.systemFont(ofSize: 10)
        bioDescription.numberOfLines = 0
        bioDescription.lineBreakMode = .byWordWrapping
        bioDescription.textAlignment = .left
        addSubview(bioDescription)
    }

    func setupConstraints() {
        cardView.translatesAutoresizingMaskIntoConstraints = false
        bioTitle.translatesAutoresizingMaskIntoConstraints = false
        bioDescription.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            cardView.leftAnchor.constraint(equalTo: leftAnchor),
            cardView.rightAnchor.constraint(equalTo: rightAnchor),
            cardView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])

        NSLayoutConstraint.activate([
            bioTitle.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            bioTitle.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            bioTitle.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 10),
            bioTitle.bottomAnchor.constraint(equalTo: cardView.topAnchor, constant: 30)
        ])

        NSLayoutConstraint.activate([
            bioDescription.leftAnchor.constraint(equalTo: bioTitle.leftAnchor),
            bioDescription.rightAnchor.constraint(equalTo: bioTitle.rightAnchor),
            bioDescription.topAnchor.constraint(equalTo: bioTitle.bottomAnchor),
            bioDescription.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
}
