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
    let ebayDataManager = eBayDataManager()
    
    // MARK: - Properties
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Store"
        self.collectionView?.backgroundColor = .white
        self.navigationController?.navigationBar.barTintColor = .orange
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.register(CategoryCell.self, forCellWithReuseIdentifier: categoryCellIdentifier)
        
//        ebayDataManager.getItem(itemID: "v1%7c122179063569%7c422420247304") { data in
//            print(data)
//        }
        
//        ebayDataManager.searchItem(query: "yoga%20ball") { data in
//            print(data)
//        }
        
        collectionView?.setNeedsUpdateConstraints()
    }
    
    // MARK: - UICollectionView Delegate and Datasource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryCellIdentifier, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }

}
