//
//  StoreViewController.swift
//  C7FIT
//
//  Created by Brandon Lee on 12/22/16.
//  Copyright © 2016 Brandon Lee. All rights reserved.
//

import UIKit

private let categoryCellIdentifier = "CategoryCell"

class StoreViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    // MARK: - Constants

    let ebayToken = EbayAPIToken()
    let ebayDataManager = EbayDataManager()

    // MARK: - Properties

    var categoryCellData: [EbayItemCategory] = []

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Store"
        collectionView?.backgroundColor = .white
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        collectionView?.register(CategoryCellController.self, forCellWithReuseIdentifier: categoryCellIdentifier)
        submitPrecuratedQueries()
        collectionView?.setNeedsUpdateConstraints()
    }

    /**
        Submit pre-curated queries for fitness eBay items
     */
    func submitPrecuratedQueries() {
        ebayToken.getOAuth2Token { OAuth2Token in
            guard let token = OAuth2Token else { return }
            self.ebayDataManager.searchItem(query: "Yoga Ball", OAuth2Token: token) { itemCategory in
                guard let itemCategory = itemCategory else { return }
                self.categoryCellData.append(itemCategory)
                self.collectionView?.reloadData()
            }

            self.ebayDataManager.searchItem(query: "Gym Shoes", OAuth2Token: token) { itemCategory in
                guard let itemCategory = itemCategory else { return }
                self.categoryCellData.append(itemCategory)
                self.collectionView?.reloadData()
            }

            self.ebayDataManager.searchItem(query: "Exercise Mat", OAuth2Token: token) { itemCategory in
                guard let itemCategory = itemCategory else { return }
                self.categoryCellData.append(itemCategory)
                self.collectionView?.reloadData()
            }
        }
    }

    // MARK: - UICollectionView Delegate and Datasource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryCellData.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryCellIdentifier, for: indexPath) as! CategoryCellController
        cell.categoryCellView.categoryTitle.text = categoryCellData[indexPath.item].title
        cell.itemCategory = categoryCellData[indexPath.item]
        cell.storeViewController = self
        return cell
    }

    // MARK: - Navigation

    func showItemDetail(item: EbayItem) {
        navigationController?.pushViewController(ItemDetailController(item: item), animated: true)
    }

    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
}
