//
//  ItemImageCell.swift
//  C7FIT
//
//  Created by Brandon Lee on 3/19/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import UIKit

class ItemImageCell: UICollectionViewCell {
    
    // MARK - Properties
    
    var itemImageView: C7FUIImageView = C7FUIImageView()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    func setup() {
        backgroundColor = .purple
        
        itemImageView.contentMode = .scaleAspectFill
        itemImageView.layer.borderColor = UIColor.gray.cgColor
        itemImageView.layer.borderWidth = 1
        itemImageView.layer.masksToBounds = true
        itemImageView.backgroundColor = .green
        itemImageView.image = UIImage(named: "club front") // TODO: Add a default image
        addSubview(itemImageView)
    }
    
    func setupConstraints() {
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        let imageTop = itemImageView.topAnchor.constraint(equalTo: topAnchor)
        let imageLeft = itemImageView.leftAnchor.constraint(equalTo: leftAnchor)
        let imageRight = itemImageView.rightAnchor.constraint(equalTo: rightAnchor)
        let imageBottom = itemImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        NSLayoutConstraint.activate([imageTop, imageLeft, imageRight, imageBottom])
    }
}
