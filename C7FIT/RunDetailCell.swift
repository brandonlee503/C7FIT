//
//  RunDetailCell.swift
//  C7FIT
//
//  Created by Michael Lee on 3/7/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import UIKit

class RunDetailCell: UITableViewCell {

    
    // MARK: - Properties
    var secondsQuantity: UILabel = UILabel()
    var distanceQuantity: UILabel = UILabel()
    var paceQuantity: UILabel = UILabel()
    
    
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
        secondsQuantity.text = "Time Elapsed: "
        addSubview(secondsQuantity)
        
        distanceQuantity.text = "Distance: "
        addSubview(distanceQuantity)
        
        paceQuantity.text = "Pace: "
        addSubview(paceQuantity)
    }
    
    func setupConstraints() {
        secondsQuantity.translatesAutoresizingMaskIntoConstraints = false
        let secondsLead = secondsQuantity.leftAnchor.constraint(equalTo: leftAnchor, constant: 10)
        let secondsTop = secondsQuantity.topAnchor.constraint(equalTo: topAnchor, constant: 10)
        NSLayoutConstraint.activate([secondsLead, secondsTop])
        
        distanceQuantity.translatesAutoresizingMaskIntoConstraints = false
        let distanceLead = distanceQuantity.leftAnchor.constraint(equalTo: leftAnchor, constant: 10)
        let distanceTop = distanceQuantity.topAnchor.constraint(equalTo: secondsQuantity.bottomAnchor, constant: 10)
        NSLayoutConstraint.activate([distanceLead, distanceTop])
        
        paceQuantity.translatesAutoresizingMaskIntoConstraints = false
        let paceLead = paceQuantity.leftAnchor.constraint(equalTo: leftAnchor, constant: 10)
        let paceTop = paceQuantity.topAnchor.constraint(equalTo: distanceQuantity.bottomAnchor, constant: 10)
        NSLayoutConstraint.activate([paceLead, paceTop])
    }
    
}
