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
private let primaryInfoIdentifier = "PrimaryItemInfoCell"
private let secondaryInfoIdentifier = "SecondaryItemInfoCell"

class ItemDetailController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    // MARK: - Variables

    var item: EbayItem?
    var itemDetail: EbayItemDetail?

    // MARK: - Initialization

    init(item: EbayItem, token: String?, dataManager: EbayDataManager) {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
        self.item = item
        fetchItemDetails(token: token, dataManager: dataManager)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Controller Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Item"
        collectionView?.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        collectionView?.register(ItemHeaderCellController.self,
                                 forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
                                 withReuseIdentifier: headerReuseIdentifer)
        collectionView?.register(ItemPrimaryInfoCell.self, forCellWithReuseIdentifier: primaryInfoIdentifier)
        collectionView?.register(ItemSecondaryInfoCell.self, forCellWithReuseIdentifier: secondaryInfoIdentifier)
    }

    func buyButtonPressed() {
        if let urlString = item?.webURL, let url = URL(string: urlString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

    func fetchItemDetails(token: String?, dataManager: EbayDataManager) {
        guard let itemID = item?.itemID, let token = token else { return }
        dataManager.getItem(itemID: itemID, OAuth2Token: token) { itemDetailJSON in
            guard let itemDetailJSON = itemDetailJSON else { return }
            self.itemDetail = EbayItemDetail(itemJSON: itemDetailJSON)
            self.collectionView?.reloadData()
        }
    }

    // MARK: - UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: primaryInfoIdentifier, for: indexPath) as? ItemPrimaryInfoCell {
                if let title = item?.title {
                    cell.itemTitle.text = title
                }
                // TODO - Potentially put price and cost parsing into a view model
                if let price = item?.price {
                    cell.price.text = "$\(price)"
                } else {
                    cell.price.text = "Unavailable"
                }
                if item?.shippingCost == "0.00" {
                    cell.shippingCost.text = "Free"
                } else {
                    cell.shippingCost.text = item?.shippingCost
                }
                cell.buyButton.addTarget(self, action: #selector(self.buyButtonPressed), for: .touchUpInside)

                return cell
            }
        } else if indexPath.item == 1 {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: secondaryInfoIdentifier, for: indexPath) as? ItemSecondaryInfoCell {
                if let condition = item?.condition {
                    cell.itemCondition.text = "Condition: \(condition)"
                } else {
                    cell.itemCondition.text = "Condition: Unavailable"
                }
                if let location = itemDetail?.location {
                    cell.itemLocation.text = "Shipping Location: \(location)"
                } else {
                    cell.itemLocation.text = "Shipping Location: Unavailable"
                }
                if let description = itemDetail?.shortDescription {
                    cell.shortDescription.text = description
                }

                return cell
            }
        }

        return UICollectionViewCell()
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                     withReuseIdentifier: headerReuseIdentifer,
                                                                     for: indexPath) as! ItemHeaderCellController
        // Get all images into one array
        if let mainImage = itemDetail?.mainImage {
            header.itemImages.append(mainImage)
        }

        if let additionalImages = itemDetail?.additionalImages {
            header.itemImages.append(contentsOf: additionalImages)
        }
        // Refresh when full resolution images are downloaded
        header.itemHeaderCellView.imageCollectionView.reloadData()
        return header
    }

    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            return CGSize(width: view.frame.width, height: 150)
        }

        return CGSize(width: view.frame.width, height: 200)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 250)
    }
}
