//
//  StoreViewController.swift
//  C7FIT
//
//  Created by Brandon Lee on 12/22/16.
//  Copyright © 2016 Brandon Lee. All rights reserved.
//

import UIKit

class StoreViewController: UICollectionViewController {

    // MARK: - Constants
    
    let storeCellIdentifier = "StoreCell"
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
        collectionView?.register(StoreCell.self, forCellWithReuseIdentifier: storeCellIdentifier)
        
            print(data)
        }
        
        collectionView?.setNeedsUpdateConstraints()
    }
    
    // MARK: - UICollectionView Delegate and Datasource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: storeCellIdentifier, for: indexPath)
        return cell
    }
}
