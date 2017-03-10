//
//  StoreViewController.swift
//  C7FIT
//
//  Created by Brandon Lee on 12/22/16.
//  Copyright © 2016 Brandon Lee. All rights reserved.
//

import UIKit

class StoreViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    // MARK: - Constants
    
    private let categoryCellIdentifier = "CategoryCell"
    let eBayToken = eBayAPIToken()
    let ebayDataManager = eBayDataManager()
    
    // MARK: - Properties
    
    var categoryCellData: [eBayItemCategory] = []
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Store"
        self.collectionView?.backgroundColor = .white
        self.navigationController?.navigationBar.barTintColor = .orange
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.register(CategoryCellController.self, forCellWithReuseIdentifier: categoryCellIdentifier)
        submitPrecuratedQueries()
        collectionView?.setNeedsUpdateConstraints()
    }
    
    /**
        Submit pre-curated queries for fitness eBay items
     */
    func submitPrecuratedQueries() {
        
        eBayToken.getOAuth2Token { OAuth2Token in
            guard let token = OAuth2Token else { return }
            self.ebayDataManager.searchItem(query: "Yoga Ball", OAuth2Token: token) { itemCategory in
                self.categoryCellData.append(itemCategory)
                self.collectionView?.reloadData()
            }
            
            self.ebayDataManager.searchItem(query: "Gym Shoes", OAuth2Token: token) { itemCategory in
                self.categoryCellData.append(itemCategory)
                self.collectionView?.reloadData()
            }
            
            self.ebayDataManager.searchItem(query: "Exercise Mat", OAuth2Token: token) { itemCategory in
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
        cell.categoryCellView.categoryTitle.text = categoryCellData[indexPath.row].title
        cell.itemCategory = categoryCellData[indexPath.row]
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
}
