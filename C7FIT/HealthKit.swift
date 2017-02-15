//
//  HealthKit.swift
//  C7FIT
//
//  Created by Michael Lee on 2/15/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import UIKit

class HealthKit: UIView {

    // MARK: - Properties
    
    var authButton: UIButton = UIButton()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Layout
    
    func setup() {
        authButton.setTitle("Authorize HealthKit", for: .normal)
        authButton.setTitleColor(.black, for: .normal)
        addSubview(authButton)
    }
    
    func setupConstraints() {
        authButton.translatesAutoresizingMaskIntoConstraints = false
        let centerTitleX = authButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        let centerTitleY = authButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        NSLayoutConstraint.activate([centerTitleX, centerTitleY])
    }

}
