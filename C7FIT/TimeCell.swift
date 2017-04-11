//
//  TimeCell.swift
//  C7FIT
//
//  Created by Michael Lee on 4/10/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import UIKit

class TimeCell: UITableViewCell {

    // MARK: - Properties

    var hourPicker = TimePickerSubCell()
    var minPicker = TimePickerSubCell()

    // MARK: - Initialization

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        hourPicker.timeLabel.text = "Hours"
        hourPicker.timePicker.tag = 0
        self.addSubview(hourPicker)

        minPicker.timeLabel.text = "Minutes"
        minPicker.timePicker.tag = 1
        self.addSubview(minPicker)
    }

    func setupConstraints() {
        let screenWidth = UIScreen.main.bounds.size.width
        let usableWidth = screenWidth * 7/8
        hourPicker.translatesAutoresizingMaskIntoConstraints = false
        let hourLeft = hourPicker.leftAnchor.constraint(equalTo: leftAnchor, constant: 0)
        let hourRight = hourPicker.rightAnchor.constraint(equalTo: leftAnchor, constant: usableWidth/2)
        let hourTop = hourPicker.topAnchor.constraint(equalTo: topAnchor, constant: 0)
        let hourBottom = hourPicker.bottomAnchor.constraint(equalTo: bottomAnchor)
        NSLayoutConstraint.activate([hourLeft, hourTop, hourRight, hourBottom])


        minPicker.translatesAutoresizingMaskIntoConstraints = false
        let minLeft = minPicker.leftAnchor.constraint(equalTo: hourPicker.rightAnchor, constant: 0)
        let minRight = minPicker.rightAnchor.constraint(equalTo: hourPicker.rightAnchor, constant: usableWidth/2)
        let minTop = minPicker.topAnchor.constraint(equalTo: topAnchor, constant: 0)
        let minBottom = minPicker.bottomAnchor.constraint(equalTo: bottomAnchor)
        NSLayoutConstraint.activate([minLeft, minTop, minRight, minBottom])
    }

}
