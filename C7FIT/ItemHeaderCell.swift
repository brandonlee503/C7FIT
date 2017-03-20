//
//  ItemHeaderCell.swift
//  C7FIT
//
//  Created by Brandon Lee on 3/19/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import UIKit

class ItemHeaderCell: UIView {
    
    // MARK: - Properties
    
    var imageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
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
        backgroundColor = .orange
        imageCollectionView.backgroundColor = .blue
        addSubview(imageCollectionView)
    }
    
    func setupConstraints() {
        imageCollectionView.translatesAutoresizingMaskIntoConstraints = false
        let collectionTop = imageCollectionView.topAnchor.constraint(equalTo: topAnchor)
        let collectionBottom = imageCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        let collectionLeft = imageCollectionView.leftAnchor.constraint(equalTo: leftAnchor)
        let collectionRight = imageCollectionView.rightAnchor.constraint(equalTo: rightAnchor)
        NSLayoutConstraint.activate([collectionTop, collectionBottom, collectionLeft, collectionRight])
    }
}
