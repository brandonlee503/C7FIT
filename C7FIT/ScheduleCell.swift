//
//  ScheduleCell.swift
//  C7FIT
//
//  Created by Michael Lee on 1/25/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import UIKit

class ScheduleCell: UITableViewCell {

    // MARK: - Properties

    let scheduleButton = UIButton()

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
        scheduleButton.setImage(UIImage(named: "club front.jpg"), for: .normal)
        addSubview(scheduleButton)
    }

    func setupConstraints() {
        scheduleButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scheduleButton.leftAnchor.constraint(equalTo: leftAnchor),
            scheduleButton.rightAnchor.constraint(equalTo: rightAnchor),
            scheduleButton.topAnchor.constraint(equalTo: topAnchor),
            scheduleButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
