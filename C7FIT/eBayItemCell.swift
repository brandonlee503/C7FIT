//
//  eBayItemCell.swift
//  C7FIT
//
//  Created by Brandon Lee on 3/3/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import UIKit

class eBayItemCell: UICollectionViewCell {
    
    // MARK - Properties
    
    var itemImageView: C7FUIImageView = C7FUIImageView()
    var itemTitle: UILabel = UILabel()
    var price: UILabel = UILabel()
    
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
        self.backgroundColor = .purple
        
        itemImageView.contentMode = .scaleAspectFill
        itemImageView.layer.borderColor = UIColor.gray.cgColor
        itemImageView.layer.borderWidth = 1
        itemImageView.layer.masksToBounds = true
        itemImageView.backgroundColor = .green
        itemImageView.image = UIImage(named: "club front") // TODO: Add a default image
        addSubview(itemImageView)
        
        itemTitle.font = UIFont.systemFont(ofSize: 8)
        itemTitle.textColor = .black
        itemTitle.backgroundColor = .green
        itemTitle.lineBreakMode = .byWordWrapping
        itemTitle.numberOfLines = 2
        addSubview(itemTitle)
        
        price.font = UIFont.systemFont(ofSize: 8)
        price.textColor = .black
        price.backgroundColor = .red
        addSubview(price)
    }
    
    func setupConstraints() {
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        let imageTop = itemImageView.topAnchor.constraint(equalTo: topAnchor)
        let imageLeft = itemImageView.leftAnchor.constraint(equalTo: leftAnchor)
        let imageRight = itemImageView.rightAnchor.constraint(equalTo: rightAnchor)
        let imageBottom = itemImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30)
        NSLayoutConstraint.activate([imageTop, imageLeft, imageRight, imageBottom])
        
        itemTitle.translatesAutoresizingMaskIntoConstraints = false
        let titleTop = itemTitle.topAnchor.constraint(equalTo: itemImageView.bottomAnchor, constant: 2)
        let titleLeft = itemTitle.leftAnchor.constraint(equalTo: itemImageView.leftAnchor)
        let titleRight = itemTitle.rightAnchor.constraint(equalTo: itemImageView.rightAnchor)
        NSLayoutConstraint.activate([titleTop, titleLeft, titleRight])
        
        price.translatesAutoresizingMaskIntoConstraints = false
        let priceTop = price.topAnchor.constraint(equalTo: itemTitle.bottomAnchor, constant: 2)
        let priceLeft = price.leftAnchor.constraint(equalTo: itemImageView.leftAnchor)
        let priceRight = price.rightAnchor.constraint(equalTo: itemImageView.rightAnchor)
        NSLayoutConstraint.activate([priceTop, priceLeft, priceRight])
    }
}
