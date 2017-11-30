//
//  NewsModels.swift
//  News
//
//  Created by mirsat on 27/11/17.
//  Copyright © 2017 mirsat. All rights reserved.
//
import SwiftyJSON

struct NewsSource {
    let name: String
    let id: String
    let description: String
    let url: String
    
    init(json: JSON) {
        self.name = json["name"].stringValue
        self.id = json["id"].stringValue
        self.description = json["description"].stringValue
        self.url = json["url"].stringValue
    }
}

struct News {
    let title: String
    let author: String?
    let publishedAt: String
    let urlToImage: String?
    let description: String
    let url: String
    
    init(json: JSON) {
        self.title = json["title"].stringValue
        self.author = json["author"].string
        self.publishedAt = json["publishedAt"].stringValue
        self.urlToImage = json["urlToImage"].string
        self.description = json["description"].stringValue
        self.url = json["url"].stringValue
    }
}
