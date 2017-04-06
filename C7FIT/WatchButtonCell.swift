//
//  WatchButtonCell.swift
//  C7FIT
//
//  Created by Michael Lee on 4/2/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import UIKit

class WatchButtonCell: UITableViewCell {

    
    
    // MARK: - Properties
    
    var startStopButton: UIButton = UIButton()
    var lapResetButton: UIButton = UIButton()
    
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
        startStopButton.setTitle("Start", for: .normal)
        startStopButton.backgroundColor = .green
        addSubview(startStopButton)
        
        lapResetButton.setTitle("Lap", for: .normal)
        lapResetButton.backgroundColor = .red
        addSubview(lapResetButton)
    }
    
    func setupConstraints() {
        let screenWidth = UIScreen.main.bounds.size.width
        startStopButton.translatesAutoresizingMaskIntoConstraints = false
        let startStopLeft = startStopButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 0)
        let startStopTop = startStopButton.topAnchor.constraint(equalTo: topAnchor, constant: 0)
        let startStopRight = startStopButton.rightAnchor.constraint(equalTo: leftAnchor, constant: screenWidth/2)
        let startStopBottom = startStopButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        NSLayoutConstraint.activate([startStopLeft, startStopTop, startStopRight, startStopBottom])
        
        lapResetButton.translatesAutoresizingMaskIntoConstraints = false
        let lapResetLeft = lapResetButton.leftAnchor.constraint(equalTo: startStopButton.rightAnchor, constant: 0)
        let lapResetTop = lapResetButton.topAnchor.constraint(equalTo: topAnchor, constant: 0)
        let lapResetRight = lapResetButton.rightAnchor.constraint(equalTo: rightAnchor, constant: 0)
        let lapResetBottom = lapResetButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        NSLayoutConstraint.activate([lapResetLeft, lapResetTop, lapResetRight, lapResetBottom])
    }
    

}
