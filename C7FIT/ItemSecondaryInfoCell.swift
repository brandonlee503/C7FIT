//
//  ItemSecondaryInfoCell.swift
//  C7FIT
//
//  Created by Brandon Lee on 4/27/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import UIKit

class ItemSecondaryInfoCell: UICollectionViewCell {

    // MARK - Properties

    var itemCondition = UILabel()
    var itemLocation = UILabel()
    var shortDescription = UILabel()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Layout

    func setup() {
        backgroundColor = .white

        itemCondition.font = .systemFont(ofSize: 14)
        itemCondition.textColor = .black
        addSubview(itemCondition)

        itemLocation.font = .systemFont(ofSize: 14)
        itemLocation.textColor = .black
        addSubview(itemLocation)

        shortDescription.font = .systemFont(ofSize: 14)
        shortDescription.textColor = .black
        shortDescription.lineBreakMode = .byWordWrapping
        shortDescription.numberOfLines = 50
        addSubview(shortDescription)
    }

    func setupConstraints() {
        itemCondition.translatesAutoresizingMaskIntoConstraints = false
        itemLocation.translatesAutoresizingMaskIntoConstraints = false
        shortDescription.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            itemCondition.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            itemCondition.leftAnchor.constraint(equalTo: leftAnchor, constant: 10)
        ])

        NSLayoutConstraint.activate([
            itemLocation.topAnchor.constraint(equalTo: itemCondition.bottomAnchor, constant: 10),
            itemLocation.leftAnchor.constraint(equalTo: itemCondition.leftAnchor)
        ])

        NSLayoutConstraint.activate([
            shortDescription.topAnchor.constraint(equalTo: itemLocation.bottomAnchor, constant: 10),
            shortDescription.leftAnchor.constraint(equalTo: itemLocation.leftAnchor),
            shortDescription.rightAnchor.constraint(equalTo: rightAnchor, constant: -10)
        ])
    }
}
