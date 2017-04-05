//
//  ItemDetailController.swift
//  C7FIT
//
//  Created by Brandon Lee on 3/10/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ItemDetailCell"
private let headerReuseIdentifer = "ItemHeader"
private let infoIdentifier = "ItemInfoCell"

class ItemDetailController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Constants
    
    var detailItem: eBayItem?
    
    // MARK: - Initialization
    
    convenience init() {
        self.init(item: nil)
    }
    
    init(item: eBayItem?) {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
        self.detailItem = item
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Item"
        collectionView?.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .black
        collectionView?.register(ItemHeaderCellController.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerReuseIdentifer)
        collectionView?.register(ItemInfoCell.self, forCellWithReuseIdentifier: infoIdentifier)
    }

    func buyButtonPressed() {
        if let urlString = detailItem?.webURL, let url = URL(string: urlString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    // MARK: - UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: infoIdentifier, for: indexPath) as? ItemInfoCell {
                cell.itemTitle.text = detailItem?.title
                // TODO - Potentially put price and cost parsing into a view model
                if let price = detailItem?.price {
                    cell.price.text = "$\(price)"
                } else {
                    cell.price.text = "Unavailable"
                }
                if detailItem?.shippingCost == "0.00" {
                    cell.shippingCost.text = "Free"
                } else {
                    cell.shippingCost.text = detailItem?.shippingCost
                }
                cell.buyButton.addTarget(self, action: #selector(self.buyButtonPressed), for: .touchUpInside)
                
                return cell
            }
        }
        
        return UICollectionViewCell()
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerReuseIdentifer, for: indexPath) as! ItemHeaderCellController
        // Get all images into one array
        if let mainImage = detailItem?.mainImage {
            header.itemImages.append(mainImage)
        }
        if let additionalImages = detailItem?.additionalImages {
            header.itemImages.append(contentsOf: additionalImages)
        }
        return header
    }

    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 250)
    }
}
