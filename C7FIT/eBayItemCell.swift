//
//  EbayItemCell.swift
//  C7FIT
//
//  Created by Brandon Lee on 3/3/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import UIKit

class EbayItemCell: UICollectionViewCell {

    // MARK - Properties

    var itemImageView = C7FUIImageView()
    var itemTitle = UILabel()
    var price = UILabel()

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
        itemImageView.contentMode = .scaleAspectFill
        itemImageView.layer.borderWidth = 0.5
        itemImageView.layer.masksToBounds = true
        // Ebay's color scheme
        itemImageView.layer.borderColor = UIColor(red: 213/255, green: 213/255, blue: 213/255, alpha: 1).cgColor
        itemImageView.backgroundColor = .lightGray
        itemImageView.image = UIImage(named: "empty_image")
        addSubview(itemImageView)

        itemTitle.font = UIFont.systemFont(ofSize: 8)
        itemTitle.textColor = .black
        itemTitle.lineBreakMode = .byWordWrapping
        itemTitle.numberOfLines = 2
        addSubview(itemTitle)

        price.font = UIFont.systemFont(ofSize: 8)
        price.textColor = .black
        addSubview(price)
    }

    func setupConstraints() {
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        itemTitle.translatesAutoresizingMaskIntoConstraints = false
        price.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            itemImageView.topAnchor.constraint(equalTo: topAnchor),
            itemImageView.leftAnchor.constraint(equalTo: leftAnchor),
            itemImageView.rightAnchor.constraint(equalTo: rightAnchor),
            itemImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30)
        ])

        NSLayoutConstraint.activate([
            itemTitle.topAnchor.constraint(equalTo: itemImageView.bottomAnchor, constant: 2),
            itemTitle.leftAnchor.constraint(equalTo: itemImageView.leftAnchor),
            itemTitle.rightAnchor.constraint(equalTo: itemImageView.rightAnchor)
        ])

        NSLayoutConstraint.activate([
            price.topAnchor.constraint(equalTo: itemTitle.bottomAnchor, constant: 2),
            price.leftAnchor.constraint(equalTo: itemImageView.leftAnchor),
            price.rightAnchor.constraint(equalTo: itemImageView.rightAnchor),
            price.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
