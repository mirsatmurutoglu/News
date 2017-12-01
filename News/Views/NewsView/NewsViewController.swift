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
    var searchResultNews: [News]!

    var searchActive = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = selectedSource.name
        self.tableView.estimatedRowHeight = 60
        carousel.delegate = self
        getNews()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    private func setupCarousel() {
        var slides = [ZKCarouselSlide]()
        news.forEach { (item) in
            let slide = ZKCarouselSlide(imageUrl: item.urlToImage, title: "", description: item.description)
            slides.append(slide)
        }
        self.carousel.pageControl.numberOfPages = slides.count
        self.carousel.slides = slides
    }

    func openNewsWebView(news: News) {
        let vc = NewsWebViewController()
        vc.newsUrl = news.url
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func getNews() {
        NewsApi.getNewsItems(selectedSource.id) { (data) in
            if let news = data {
                self.news = news
                self.setupCarousel()
            }
        }
    }
    
    func searchNewsItems(text: String) {
        NewsApi.getSearchedNewsItems(text, selectedSource.id) { (data) in
            if let news = data {
                self.searchResultNews = news
                self.tableView.reloadData()
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
        if searchResultNews != nil && !searchResultNews.isEmpty {
            searchResultNews.removeAll()
        }
        searchBar.resignFirstResponder()
        self.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            searchNewsItems(text: searchText)
        }
    }
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultNews != nil ? searchResultNews.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! SearchResultTableViewCell
        cell.setSearchResultNews(news: searchResultNews[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        openNewsWebView(news: searchResultNews[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
}

extension NewsViewController: ZKCarouselDelegate {
    func selectedSlider(index: Int) {
        openNewsWebView(news: news[index])
    }
}
