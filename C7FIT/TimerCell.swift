//
//  TimerCell.swift
//  C7FIT
//
//  Created by Michael Lee on 3/8/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import UIKit

class TimerCell: UITableViewCell {

    // MARK: - Properties

    var timeLabel = UILabel()

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
        timeLabel.text = "00:00:00"
        timeLabel.font = timeLabel.font.withSize(50.0)
        timeLabel.textColor = .orange
        self.addSubview(timeLabel)
    }

    func setupConstraints() {
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        let centerTimeX = timeLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        let centerTimeY = timeLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        NSLayoutConstraint.activate([centerTimeX, centerTimeY])
    }

    func changeTime(time: String) {
        timeLabel.text = time
    }

}
