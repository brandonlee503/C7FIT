//
//  ActivityHealthKitTableTableViewCell.swift
//  C7FIT
//
//  Created by Michael Lee on 2/13/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import UIKit

class HealthKitTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    lazy var ActivityTitle: UILabel = UILabel()
    
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
        ActivityTitle.text = "Health Stats"
        ActivityTitle.textAlignment = NSTextAlignment.center
        addSubview(ActivityTitle)
    }
    
    func setupConstraints() {
        ActivityTitle.translatesAutoresizingMaskIntoConstraints = false
        let titleLead = ActivityTitle.leftAnchor.constraint(equalTo: leftAnchor, constant:10)
        let titleTrail = ActivityTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant:-10)
        let titleTop = ActivityTitle.topAnchor.constraint(equalTo: topAnchor, constant: 20)
        NSLayoutConstraint.activate([titleLead,titleTrail,titleTop])
        
    }

}
