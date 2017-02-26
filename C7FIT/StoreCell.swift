//
//  StoreCell.swift
//  C7FIT
//
//  Created by Brandon Lee on 2/25/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import UIKit

class StoreCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    var storeLabel: UILabel = UILabel()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    func setup() {
        storeLabel.text = "Logout"
        storeLabel.textColor = .black
        addSubview(storeLabel)
    }
    
    func setupConstraints() {
        storeLabel.translatesAutoresizingMaskIntoConstraints = false
        let logoutX = storeLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        let logoutY = storeLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        NSLayoutConstraint.activate([logoutX, logoutY])
    }
}
