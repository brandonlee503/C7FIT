//
//  GenLRButtonCell.swift
//  C7FIT
//
//  Created by Michael Lee on 4/11/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import UIKit

class GenLRButtonCell: UITableViewCell {

    // MARK: - Properties

    var leftButton = UIButton()
    var rightButton = UIButton()

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
        // Blank buttons
        addSubview(leftButton)
        addSubview(rightButton)
    }

    func setupConstraints() {
        let screenWidth = UIScreen.main.bounds.size.width
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        let leftLeft = leftButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 0)
        let leftTop = leftButton.topAnchor.constraint(equalTo: topAnchor, constant: 0)
        let leftRight = leftButton.rightAnchor.constraint(equalTo: leftAnchor, constant: screenWidth/2)
        let leftBottom = leftButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        NSLayoutConstraint.activate([leftLeft, leftTop, leftRight, leftBottom])

        rightButton.translatesAutoresizingMaskIntoConstraints = false
        let rightLeft = rightButton.leftAnchor.constraint(equalTo: leftButton.rightAnchor, constant: 0)
        let rightTop = rightButton.topAnchor.constraint(equalTo: topAnchor, constant: 0)
        let rightRight = rightButton.rightAnchor.constraint(equalTo: rightAnchor, constant: 0)
        let rightBottom = rightButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        NSLayoutConstraint.activate([rightLeft, rightTop, rightRight, rightBottom])
    }

}
