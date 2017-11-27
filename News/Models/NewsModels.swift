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
