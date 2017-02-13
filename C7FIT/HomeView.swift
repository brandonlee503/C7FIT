//
//  HomeView.swift
//  C7FIT
//
//  Created by Brandon Lee on 12/21/16.
//  Copyright © 2016 Brandon Lee. All rights reserved.
//

import UIKit

class HomeView: UIView {

    // MARK: - Properties
    
    var titleLabel: UILabel = UILabel()
    
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
        titleLabel.text = "Home"
        addSubview(titleLabel)
    }
    
    func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        let centerTitleX = titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        let centerTitleY = titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        NSLayoutConstraint.activate([centerTitleX, centerTitleY])
    }
}
