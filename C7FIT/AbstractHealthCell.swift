//
//  AbstractHealthCell.swift
//  C7FIT
//
//  Created by Brandon Lee on 1/31/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import UIKit

class AbstractHealthCell: UITableViewCell {
    
    // MARK: - Properties
    
    var dataLabel: UILabel = UILabel()
    var dataField: UITextField = UITextField()
    
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
        dataLabel.backgroundColor = .red
        addSubview(dataLabel)
        
        dataField.backgroundColor = .cyan
        addSubview(dataField)
    }
    
    func setupConstraints() {
        dataLabel.translatesAutoresizingMaskIntoConstraints = false
        let labelLeading = dataLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
        let labelTop = dataLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10)
        let labelBottom = dataLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        NSLayoutConstraint.activate([labelLeading, labelTop, labelBottom])
        
        dataField.translatesAutoresizingMaskIntoConstraints = false
        let fieldTrailing = dataField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        let fieldTop = dataField.topAnchor.constraint(equalTo: topAnchor, constant: 10)
        let fieldBottom = dataField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        NSLayoutConstraint.activate([fieldTrailing, fieldTop, fieldBottom])
    }
}
