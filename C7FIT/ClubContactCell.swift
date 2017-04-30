//
//  ClubContactCell.swift
//  C7FIT
//
//  Created by Michael Lee on 2/1/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import UIKit

class ClubContactCell: UITableViewCell {

    // MARK: - Properties

    var contactButton = UIButton()

    // MARK: - Initialization

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        print("Contact cell")
        setup()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Layout

    func setup() {
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
        NSLayoutConstraint.activate([titleLead, titleTrail, titleTop, titleBot])

    }

}
