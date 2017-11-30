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
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var news: [News]!
    var searchActive = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = selectedSource.name
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

extension NewsViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.tableView.reloadData()
    }
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
}
