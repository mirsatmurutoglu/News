//
//  NewsSourcesViewController.swift
//  News
//
//  Created by mirsat on 27/11/17.
//  Copyright © 2017 mirsat. All rights reserved.
//

import UIKit
import SwiftyJSON

class NewsSourcesViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    private var newsSourceCollectionViewAdapter: CollectionViewAdapter<NewsSourceCollectionViewCell, NewsSource>!
    fileprivate let reuseIdentifierForNewsSourceCell = "NewsSourceCollectionViewCell"
    var newsSources: [NewsSource]!
    var selectedSource: NewsSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getNewsSources()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getNewsSources() {
        NewsApi.getNewsSources { (data) in
            if let sources = data {
                self.newsSources = sources
                self.setupCollectionView()
            }
        }
    }
    
    func setupCollectionView() {
        collectionView.register(UINib(nibName: "NewsSourceCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifierForNewsSourceCell)
        
        self.newsSourceCollectionViewAdapter = CollectionViewAdapter(
            collectionView: self.collectionView,
            cellReuseIdentifier: reuseIdentifierForNewsSourceCell,
            items: newsSources,
            cellConfigurationHandler: { (cell, source) in
                cell.setNewsInformation(source: source)
        },
            cellSizeHandler: { (cell, item) -> (CGSize) in
                let viewWidth = UIScreen.main.bounds.size.width
                return CGSize(width: viewWidth / 2 - 20, height: viewWidth / 2 - 20)
        },
            didSelectItemHandler: { (item) in
                self.selectedSource = item
                self.performSegue(withIdentifier: "newsView", sender: nil)
        })
        self.collectionView.dataSource = self.newsSourceCollectionViewAdapter
        self.collectionView.delegate = self.newsSourceCollectionViewAdapter
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "newsView" {
            let vc = segue.destination as! NewsViewController
            vc.selectedSource = self.selectedSource
        }
    }
}

