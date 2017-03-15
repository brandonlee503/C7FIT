//
//  CategoryCellController.swift
//  C7FIT
//
//  Created by Brandon Lee on 2/25/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import UIKit

private let itemCellIdentifier = "ItemCell"

class CategoryCellController: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Constants
    
    let categoryCellView = CategoryCell()
    
    // MARK: - Properties
    
    var itemCategory: eBayItemCategory?
    var storeViewController: StoreViewController?
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        categoryCellView.itemCollectionView.delegate = self
        categoryCellView.itemCollectionView.dataSource = self
        categoryCellView.itemCollectionView.register(eBayItemCell.self, forCellWithReuseIdentifier: itemCellIdentifier)
        self.contentView.addSubview(categoryCellView)
        setupConstraints()
        self.contentView.setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    func setupConstraints() {
        categoryCellView.translatesAutoresizingMaskIntoConstraints = false
        let topView = categoryCellView.topAnchor.constraint(equalTo: self.contentView.topAnchor)
        let bottomView = categoryCellView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        let leftView = categoryCellView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor)
        let rightView = categoryCellView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor)
        NSLayoutConstraint.activate([topView, bottomView, leftView, rightView])
    }
    
    // MARK: - UICollectionView Delegate and Data Source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let itemCount = itemCategory?.items.count {
            return itemCount
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemCellIdentifier, for: indexPath) as! eBayItemCell
        if let itemImage = itemCategory?.items[indexPath.item].mainImage {
            cell.itemImageView.downloadImageFrom(url: itemImage, imageMode: .scaleAspectFit)
        }
        if let title = itemCategory?.items[indexPath.item].title {
            cell.itemTitle.text = title
        }
        if let price = itemCategory?.items[indexPath.item].price {
            cell.price.text = "$\(price)"
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let item = itemCategory?.items[indexPath.item] {
            storeViewController?.showItemDetail(item: item)
        }
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: frame.height - 0.5 - 30) // 0.5 offset for divider line, 30 offset for title
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 14, 0, 14)
    }
}
