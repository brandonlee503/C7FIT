//
//  CategoryCell.swift
//  C7FIT
//
//  Created by Brandon Lee on 3/7/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import UIKit

class CategoryCell: UIView {

    // MARK: - Properties

    var categoryTitle = UILabel()

    var itemCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        return collectionView
    }()

    var dividerLine = UIView()

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
        categoryTitle.text = "Category Title"
        categoryTitle.font.withSize(14)
        categoryTitle.textColor = .black
        addSubview(categoryTitle)

        addSubview(itemCollectionView)

        dividerLine.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        addSubview(dividerLine)
    }

    func setupConstraints() {
        categoryTitle.translatesAutoresizingMaskIntoConstraints = false
        itemCollectionView.translatesAutoresizingMaskIntoConstraints = false
        dividerLine.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            categoryTitle.topAnchor.constraint(equalTo: topAnchor),
            categoryTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
        ])

        NSLayoutConstraint.activate([
            itemCollectionView.topAnchor.constraint(equalTo: categoryTitle.bottomAnchor),
            // Bottom offset for divider line
            itemCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            itemCollectionView.leftAnchor.constraint(equalTo: leftAnchor),
            itemCollectionView.rightAnchor.constraint(equalTo: rightAnchor)
        ])

        NSLayoutConstraint.activate([
            dividerLine.topAnchor.constraint(equalTo: itemCollectionView.bottomAnchor, constant: 9.5),
            dividerLine.bottomAnchor.constraint(equalTo: bottomAnchor),
            dividerLine.leftAnchor.constraint(equalTo: leftAnchor),
            dividerLine.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
}
