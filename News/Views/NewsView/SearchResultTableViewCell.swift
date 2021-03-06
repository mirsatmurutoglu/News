//
//  SearchResultTableViewCell.swift
//  News
//
//  Created by mirsat on 30/11/17.
//  Copyright © 2017 mirsat. All rights reserved.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsImageWidth: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setSearchResultNews(news: News) {
        self.titleLabel.text = news.title
        self.descriptionLabel.text = news.description
        self.dateLabel.text = news.publishedAt

        if let imgUrl = news.urlToImage {
            ImageLoader.loadImageFromUrl(imgUrl) { (image, returnedUrl) in
                if imgUrl == returnedUrl {
                    self.newsImageView.image = image
                    self.newsImageWidth.constant = 100
                } else {
                    self.newsImageView.image = nil
                    self.newsImageWidth.constant = 0
                }
            }
        } else {
            self.newsImageView.image = nil
            self.newsImageWidth.constant = 0
        }

        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
}
