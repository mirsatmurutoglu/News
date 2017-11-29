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

    override func viewDidLoad() {
        super.viewDidLoad()
        getNews()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getNews() {
        NewsApi.getNewsItems(selectedSource.id) { (data) in
            if let news = data {
                // do work
            }
        }
    }
}
