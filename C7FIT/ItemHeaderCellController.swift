//
//  ItemHeaderCellController.swift
//  C7FIT
//
//  Created by Brandon Lee on 3/19/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import UIKit

private let itemImageCellIdentifier = "ItemImageCell"

class ItemHeaderCellController: UICollectionViewCell, UICollectionViewDelegate,
                                UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    // MARK: - Constants

    let itemHeaderCellView = ItemHeaderCell()

    // MARK: - Properties

    var itemImages: [URL?] = []

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .blue
        itemHeaderCellView.imageCollectionView.delegate = self
        itemHeaderCellView.imageCollectionView.dataSource = self
        itemHeaderCellView.imageCollectionView.register(ItemImageCell.self, forCellWithReuseIdentifier: itemImageCellIdentifier)
        self.contentView.addSubview(itemHeaderCellView)
        setupConstraints()
        contentView.setNeedsUpdateConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Layout

    func setupConstraints() {
        itemHeaderCellView.translatesAutoresizingMaskIntoConstraints = false
        let topView = itemHeaderCellView.topAnchor.constraint(equalTo: self.contentView.topAnchor)
        let bottomView = itemHeaderCellView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        let leftView = itemHeaderCellView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor)
        let rightView = itemHeaderCellView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor)
        NSLayoutConstraint.activate([topView, bottomView, leftView, rightView])
    }

    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemImages.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemImageCellIdentifier, for: indexPath) as! ItemImageCell
        if let itemImage = itemImages[indexPath.item] {
            cell.itemImageView.downloadImageFrom(url: itemImage, imageMode: .scaleAspectFit)
        }
        return cell
    }

    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: frame.height)
    }
}
