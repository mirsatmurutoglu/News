//
//  NewsSourceCollectionViewCell.swift
//  News
//
//  Created by mirsat on 28/11/17.
//  Copyright © 2017 mirsat. All rights reserved.
//

import UIKit

class NewsSourceCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        name.layer.cornerRadius = 5
        name.layer.borderWidth = 1.0
        name.layer.borderColor = UIColor.clear.cgColor
        name.layer.masksToBounds = true
        name.clipsToBounds = true
    }
    
    func setNewsInformation(source: NewsSource) {
        self.name.text = source.name
    }
}
