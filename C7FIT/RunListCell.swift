//
//  RunListTableViewCell.swift
//  C7FIT
//
//  Created by Michael Lee on 3/6/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import UIKit

class RunListCell: UITableViewCell {

    // MARK: - Properties

    var titleLabel: UILabel = UILabel()
    var valLabel: UILabel = UILabel()

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
        titleLabel.backgroundColor = .green
        addSubview(titleLabel)

        valLabel.backgroundColor = .green
        addSubview(valLabel)
    }

    func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        let titleLead = titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
        let titleTop = titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10)
        let titleBottom = titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        NSLayoutConstraint.activate([titleLead, titleTop, titleBottom])

        valLabel.translatesAutoresizingMaskIntoConstraints = false
        let dateTrail = valLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        let dateTop = valLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor)
        let dateBottom = valLabel.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor)
        NSLayoutConstraint.activate([dateTrail, dateTop, dateBottom])
    }
}
