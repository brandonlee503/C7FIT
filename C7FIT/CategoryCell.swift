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

    var categoryTitle: UILabel = UILabel()

    var itemCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()

    var dividerLine: UIView = UIView()

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
        self.backgroundColor = .orange
        categoryTitle.text = "Category Title"
        categoryTitle.font.withSize(14)
        categoryTitle.textColor = .black
        categoryTitle.backgroundColor = .cyan
        addSubview(categoryTitle)

        itemCollectionView.backgroundColor = .blue
        addSubview(itemCollectionView)

        dividerLine.backgroundColor = .yellow//UIColor(white: 0.5, alpha: 0.5)
        addSubview(dividerLine)
    }

    func setupConstraints() {
        categoryTitle.translatesAutoresizingMaskIntoConstraints = false
        let titleTop = categoryTitle.topAnchor.constraint(equalTo: topAnchor)
        let titleLeft = categoryTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
        NSLayoutConstraint.activate([titleTop, titleLeft])

        // Bottom offset for divider line
        itemCollectionView.translatesAutoresizingMaskIntoConstraints = false
        let collectionTop = itemCollectionView.topAnchor.constraint(equalTo: categoryTitle.bottomAnchor)
        let collectionBottom = itemCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -0.5)
        let collectionLeft = itemCollectionView.leftAnchor.constraint(equalTo: leftAnchor)
        let collectionRight = itemCollectionView.rightAnchor.constraint(equalTo: rightAnchor)
        NSLayoutConstraint.activate([collectionTop, collectionBottom, collectionLeft, collectionRight])

        dividerLine.translatesAutoresizingMaskIntoConstraints = false
        let dividerLineTop = dividerLine.topAnchor.constraint(equalTo: itemCollectionView.bottomAnchor)
        let dividerLineBottom = dividerLine.bottomAnchor.constraint(equalTo: bottomAnchor)
        let dividerLineLeft = dividerLine.leftAnchor.constraint(equalTo: leftAnchor)
        let dividerLineRight = dividerLine.rightAnchor.constraint(equalTo: rightAnchor)
        NSLayoutConstraint.activate([dividerLineTop, dividerLineBottom, dividerLineLeft, dividerLineRight])
    }
}
