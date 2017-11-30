//
//  CollectionViewAdapter.swift
//  News
//
//  Created by mirsat on 28/11/17.
//  Copyright © 2017 mirsat. All rights reserved.
//

import UIKit

class CollectionViewAdapter<CellType: UICollectionViewCell, ItemType: Any>: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private let collectionView: UICollectionView
    private let cellReuseIdentifier: String
    private let items: [ItemType]?
    private let cellConfigurationHandler: (CellType, ItemType) -> Void
    private let cellSizeHandler: (CellType, ItemType) -> (CGSize)
    private let didSelectItemHandler: (ItemType) -> Void
    let sectionInsets = UIEdgeInsets(top: 10.0, left: 10, bottom: 10.0, right: 10)
    
    init(collectionView: UICollectionView, cellReuseIdentifier: String, items: [ItemType]?, cellConfigurationHandler: @escaping (CellType, ItemType) -> Void, cellSizeHandler: @escaping (CellType, ItemType) -> (CGSize), didSelectItemHandler: @escaping (ItemType) -> Void) {
        self.collectionView = collectionView
        self.cellReuseIdentifier = cellReuseIdentifier
        self.items = items
        self.cellConfigurationHandler = cellConfigurationHandler
        self.cellSizeHandler = cellSizeHandler
        self.didSelectItemHandler = didSelectItemHandler
        super.init()
    }
    
    // MARK: - UICollectionViewDataSource, UICollectionViewDelegate protocols
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items != nil ? items!.count : 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as? CellType
        cellConfigurationHandler(cell!, items![indexPath.row])
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectItemHandler(items![indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let cell = Bundle.main.loadNibNamed(cellReuseIdentifier, owner: self, options: nil)?[0] as? CellType else {
            return CGSize.zero
        }
        
        let size = cellSizeHandler(cell, items![indexPath.row])
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.zero
    }
    
}
