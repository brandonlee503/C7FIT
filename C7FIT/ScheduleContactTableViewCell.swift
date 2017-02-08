//
//  ScheduleContactTableViewCell.swift
//  C7FIT
//
//  Created by Michael Lee on 2/1/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import UIKit

class ScheduleContactTableViewCell: UITableViewCell {

    var contactButton: UIButton = UIButton()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        print("Contact cell")
        setup()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setup(){
        contactButton.backgroundColor = .white
        contactButton.setTitle("Contact Us", for: .normal)
        contactButton.setTitleColor(.black, for: .normal)
        addSubview(contactButton)
    }
    
    func setupConstraints() {
        contactButton.translatesAutoresizingMaskIntoConstraints = false
        let titleLead = contactButton.leftAnchor.constraint(equalTo: leftAnchor, constant:0)
        let titleTrail = contactButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant:0)
        let titleTop = contactButton.topAnchor.constraint(equalTo: topAnchor, constant: 0)
        let titleBot = contactButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        NSLayoutConstraint.activate([titleLead,titleTrail,titleTop,titleBot])
        
    }


}
