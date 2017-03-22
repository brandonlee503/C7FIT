//
//  RunDetailCell.swift
//  C7FIT
//
//  Created by Michael Lee on 3/7/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import UIKit

class RunDetailCell: UITableViewCell {

    
    // MARK: - Propertiess
    var secondsText: UILabel = UILabel()
    var distanceText: UILabel = UILabel()
    var paceText: UILabel = UILabel()
    
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
        secondsText.text = "Time Elapsed: "
        addSubview(secondsText)
        
        distanceText.text = "Distance: "
        addSubview(distanceText)
        
        paceText.text = "Pace: "
        addSubview(paceText)
        
        secondsQuantity.text = ""
        addSubview(secondsQuantity)
        
        distanceQuantity.text = ""
        addSubview(distanceQuantity)
        
        paceQuantity.text = ""
        addSubview(paceQuantity)
    }
    
    func setupConstraints() {
        secondsText.translatesAutoresizingMaskIntoConstraints = false
        let secondsTextLead = secondsText.leftAnchor.constraint(equalTo: leftAnchor, constant: 10)
        let secondsTextTop = secondsText.topAnchor.constraint(equalTo: topAnchor, constant: 10)
        NSLayoutConstraint.activate([secondsTextLead, secondsTextTop])
        
        distanceText.translatesAutoresizingMaskIntoConstraints = false
        let distanceTextLead = distanceText.leftAnchor.constraint(equalTo: leftAnchor, constant: 10)
        let distanceTextTop = distanceText.topAnchor.constraint(equalTo: secondsText.bottomAnchor, constant: 10)
        NSLayoutConstraint.activate([distanceTextLead, distanceTextTop])
        
        paceText.translatesAutoresizingMaskIntoConstraints = false
        let paceTextLead = paceText.leftAnchor.constraint(equalTo: leftAnchor, constant: 10)
        let paceTextTop = paceText.topAnchor.constraint(equalTo: distanceText.bottomAnchor, constant: 10)
        NSLayoutConstraint.activate([paceTextLead, paceTextTop])
        
        secondsQuantity.translatesAutoresizingMaskIntoConstraints = false
        let secondsLead = secondsQuantity.leftAnchor.constraint(equalTo: secondsText.rightAnchor, constant: 10)
        let secondsTop = secondsQuantity.topAnchor.constraint(equalTo: secondsText.topAnchor)
        NSLayoutConstraint.activate([secondsLead, secondsTop])
        
        distanceQuantity.translatesAutoresizingMaskIntoConstraints = false
        let distanceLead = distanceQuantity.leftAnchor.constraint(equalTo: distanceText.rightAnchor, constant: 10)
        let distanceTop = distanceQuantity.topAnchor.constraint(equalTo: distanceText.topAnchor)
        NSLayoutConstraint.activate([distanceLead, distanceTop])
        
        paceQuantity.translatesAutoresizingMaskIntoConstraints = false
        let paceLead = paceQuantity.leftAnchor.constraint(equalTo: paceText.rightAnchor, constant: 10)
        let paceTop = paceQuantity.topAnchor.constraint(equalTo: paceText.topAnchor)
        NSLayoutConstraint.activate([paceLead, paceTop])
    }
    
}
