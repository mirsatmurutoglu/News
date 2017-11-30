//
//  NewsViewController.swift
//  News
//
//  Created by mirsat on 29/11/17.
//  Copyright © 2017 mirsat. All rights reserved.
//

import UIKit
import SwiftyJSON

class NewsViewController: UIViewController {
    
    var selectedSource: NewsSource!
    @IBOutlet var carousel: ZKCarousel! = ZKCarousel()
    var news: [News]!

    override func viewDidLoad() {
        super.viewDidLoad()
        getNews()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    private func setupCarousel() {

        var slides = [ZKCarouselSlide]()
        news.forEach { (item) in
            let desc = item.description != nil ? item.description! : ""
            let slide = ZKCarouselSlide(imageUrl: item.urlToImage, title: "", description: desc)
            slides.append(slide)
        }
        // Add the slides to the carousel
        self.carousel.pageControl.numberOfPages = slides.count
        self.carousel.slides = slides
    }

    func getNews() {
        NewsApi.getNewsItems(selectedSource.id) { (data) in
            if let news = data {
                // do work
                self.news = news
                self.setupCarousel()
            }
        }
    }
}
