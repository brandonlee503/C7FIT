//
//  CategoryCell.swift
//  C7FIT
//
//  Created by Brandon Lee on 2/25/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import UIKit

// TODO: Move view code to seperate class
class CategoryCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Constants
    
    private let itemCellIdentifier = "ItemCell"
    
    // MARK: - Properties
    
    var categoryTitle: UILabel = UILabel()
    var dividerLine: UIView = UIView()
    
    var itemCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    var itemCategory: eBayItemCategory?
    
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
        
        itemCollectionView.delegate = self
        itemCollectionView.dataSource = self
        itemCollectionView.register(eBayItemCell.self, forCellWithReuseIdentifier: itemCellIdentifier)
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
    
    // MARK: - UICollectionView Delegate and Data Source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemCellIdentifier, for: indexPath) as! eBayItemCell
        if let title = itemCategory?.items[indexPath.row].title {
            cell.itemTitle.text = title
        }
        if let price = itemCategory?.items[indexPath.row].price {
            cell.price.text = price
        }
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: frame.height - 0.5 - 30) // 0.5 offset for divider line, 30 offset for title
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 14, 0, 14)
    }
}
