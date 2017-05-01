//
//  ActivityViewCountTableViewCell.swift
//  C7FIT
//
//  Created by Michael Lee on 2/13/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import UIKit

class CountTableViewCell: UITableViewCell {

    // MARK: - Properties

    lazy var activityTitle = UILabel()

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
        activityTitle.text = "Countdown Timer"
        activityTitle.textAlignment = NSTextAlignment.center
        addSubview(activityTitle)
    }

    func setupConstraints() {
        activityTitle.translatesAutoresizingMaskIntoConstraints = false
        let titleX = activityTitle.centerXAnchor.constraint(equalTo: centerXAnchor)
        let titleY = activityTitle.centerYAnchor.constraint(equalTo: centerYAnchor)
        NSLayoutConstraint.activate([titleX, titleY])
    }

}
