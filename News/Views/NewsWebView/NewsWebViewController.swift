//
//  NewsWebViewController.swift
//  News
//
//  Created by mirsat on 1/12/17.
//  Copyright © 2017 mirsat. All rights reserved.
//

import UIKit

class NewsWebViewController: UIViewController, UIWebViewDelegate {
    
    var webView: UIWebView!
    var newsUrl:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView = UIWebView(frame: UIScreen.main.bounds)
        view.addSubview(webView)
        
        if let url = URL(string: newsUrl) {
            let request = URLRequest(url: url)
            webView.loadRequest(request)
        }
    }
}
