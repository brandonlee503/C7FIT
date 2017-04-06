//
//  StartStopCell.swift
//  C7FIT
//
//  Created by Michael Lee on 3/7/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import UIKit

class StartStopCell: UITableViewCell {

    // MARK: - Properties

    var startButton: UIButton = UIButton()
    var stopButton: UIButton = UIButton()

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
        startButton.setTitle("Start Run", for: .normal)
        startButton.backgroundColor = .green
        addSubview(startButton)

        stopButton.setTitle("Stop Run", for: .normal)
        stopButton.backgroundColor = .red
        addSubview(stopButton)
    }

    func setupConstraints() {
        let screenWidth = UIScreen.main.bounds.size.width
        startButton.translatesAutoresizingMaskIntoConstraints = false
        let startLeft = startButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 0)
        let startTop = startButton.topAnchor.constraint(equalTo: topAnchor, constant: 0)
        let startRight = startButton.rightAnchor.constraint(equalTo: leftAnchor, constant: screenWidth/2)
        let startBottom = startButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        NSLayoutConstraint.activate([startLeft, startTop, startRight, startBottom])

        stopButton.translatesAutoresizingMaskIntoConstraints = false
        let stopLeft = stopButton.leftAnchor.constraint(equalTo: startButton.rightAnchor, constant: 0)
        let stopTop = stopButton.topAnchor.constraint(equalTo: topAnchor, constant: 0)
        let stopRight = stopButton.rightAnchor.constraint(equalTo: rightAnchor, constant: 0)
        let stopBottom = stopButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        NSLayoutConstraint.activate([stopLeft, stopTop, stopRight, stopBottom])
    }

}
