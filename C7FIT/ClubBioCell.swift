//
//  ScheduleBioTableViewCell.swift
//  C7FIT
//
//  Created by Michael Lee on 2/1/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import UIKit

class ScheduleBioTableViewCell: UITableViewCell {

    // MARK: - Properties

    lazy var bioTitle = UILabel()
    lazy var bioText = UILabel()

    // MARK: - Initialization

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        print("Bio cell")
        setup()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Layout

    func setup() {
        bioTitle.backgroundColor = .white
        bioTitle.text = "Club Bio"
        bioTitle.textAlignment = NSTextAlignment.center
        addSubview(bioTitle)

        bioText.backgroundColor = .white
        bioText.text = "club bio placeholder text i love gym woo club bio placeholder text i l"
        bioText.numberOfLines = 0
        bioText.lineBreakMode = .byWordWrapping
        bioText.textAlignment = NSTextAlignment.center
        addSubview(bioText)

    }

    func setupConstraints() {
        bioTitle.translatesAutoresizingMaskIntoConstraints = false
        let titleLead = bioTitle.leftAnchor.constraint(equalTo: leftAnchor, constant:10)
        let titleTrail = bioTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant:-10)
        let titleTop = bioTitle.topAnchor.constraint(equalTo: topAnchor, constant: 10)
        let titleBot = bioTitle.bottomAnchor.constraint(equalTo: bioText.topAnchor, constant: -10)
        NSLayoutConstraint.activate([titleLead, titleTrail, titleTop, titleBot])

        bioText.translatesAutoresizingMaskIntoConstraints = false
        let TextLead = bioText.leftAnchor.constraint(equalTo: leftAnchor, constant:10)
        let TextTrail = bioText.trailingAnchor.constraint(equalTo: trailingAnchor, constant:-10)
        let TextTop = bioText.topAnchor.constraint(equalTo: bioTitle.bottomAnchor, constant:10)
        NSLayoutConstraint.activate([TextLead, TextTrail, TextTop])

    }

}
