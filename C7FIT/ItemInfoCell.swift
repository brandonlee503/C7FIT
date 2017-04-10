//
//  ItemInfoCell.swift
//  C7FIT
//
//  Created by Brandon Lee on 3/20/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import UIKit

class ItemInfoCell: UICollectionViewCell {

    // MARK - Properties

    var itemTitle = UILabel()
    var price = UILabel()
    var shippingTitle = UILabel()
    var shippingCost = UILabel()
    var buyButton = UIButton()

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
        self.backgroundColor = .purple

        itemTitle.font = UIFont.systemFont(ofSize: 18)
        itemTitle.textColor = .black
        itemTitle.backgroundColor = .green
        itemTitle.lineBreakMode = .byWordWrapping
        itemTitle.numberOfLines = 2
        addSubview(itemTitle)

        price.font = UIFont.systemFont(ofSize: 20)
        price.textColor = .black
        price.backgroundColor = .red
        addSubview(price)

        shippingCost.font = UIFont.systemFont(ofSize: 14)
        shippingCost.textColor = .black
        shippingCost.backgroundColor = .blue
        addSubview(shippingCost)

        shippingTitle.font = UIFont.systemFont(ofSize: 8)
        shippingTitle.textColor = .gray
        shippingTitle.backgroundColor = .orange
        shippingTitle.text = "Shipping"
        addSubview(shippingTitle)

        buyButton.setTitle("Buy It Now", for: .normal)
        buyButton.setTitleColor(.white, for: .normal)
        buyButton.backgroundColor = .blue
        buyButton.layer.cornerRadius = 5
        addSubview(buyButton)
    }

    func setupConstraints() {

        itemTitle.translatesAutoresizingMaskIntoConstraints = false
        let titleTop = itemTitle.topAnchor.constraint(equalTo: topAnchor, constant: 5)
        let titleLeft = itemTitle.leftAnchor.constraint(equalTo: leftAnchor, constant: 5)
        let titleRight = itemTitle.rightAnchor.constraint(equalTo: rightAnchor, constant: -5)
        NSLayoutConstraint.activate([titleTop, titleLeft, titleRight])

        price.translatesAutoresizingMaskIntoConstraints = false
        let priceTop = price.topAnchor.constraint(equalTo: itemTitle.bottomAnchor, constant: 5)
        let priceLeft = price.leftAnchor.constraint(equalTo: itemTitle.leftAnchor)
        NSLayoutConstraint.activate([priceTop, priceLeft])

        shippingCost.translatesAutoresizingMaskIntoConstraints = false
        let shippingCostTop = shippingCost.topAnchor.constraint(equalTo: price.topAnchor)
        let shippingCostRight = shippingCost.rightAnchor.constraint(equalTo: rightAnchor, constant: -5)
        NSLayoutConstraint.activate([shippingCostTop, shippingCostRight])

        shippingTitle.translatesAutoresizingMaskIntoConstraints = false
        let shippingTitleTop = shippingTitle.topAnchor.constraint(equalTo: shippingCost.bottomAnchor, constant: 2)
        let shippingTitleRight = shippingTitle.rightAnchor.constraint(equalTo: shippingCost.rightAnchor)
        NSLayoutConstraint.activate([shippingTitleTop, shippingTitleRight])

        buyButton.translatesAutoresizingMaskIntoConstraints = false
        let buttonTop = buyButton.topAnchor.constraint(equalTo: price.bottomAnchor, constant: 35)
        let buttonLeft = buyButton.leftAnchor.constraint(equalTo: price.leftAnchor)
        let buttonRight = buyButton.rightAnchor.constraint(equalTo: shippingTitle.rightAnchor)
        NSLayoutConstraint.activate([buttonTop, buttonLeft, buttonRight])
    }
}
