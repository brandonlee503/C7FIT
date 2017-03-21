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
        collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        print(detailItem?.webURL ?? "missing")
    }

    // MARK: - UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
    
        return cell
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 250)
    }
}
