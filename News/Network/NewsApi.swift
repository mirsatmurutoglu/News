//
//  NewsApi.swift
//  News
//
//  Created by mirsat on 27/11/17.
//  Copyright © 2017 mirsat. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import SwiftyJSON

public class NewsApi {

    // MARK: Get news Sources
    class func getNewsSources(completion: @escaping (_ data: [NewsSource]?) -> Void) {
        
        let newsSourcesUrl = ApiDefaults.baseUrl + ApiDefaults.sourcesPath + "?apiKey=" + ApiDefaults.apiKey
        
        Alamofire.request(newsSourcesUrl, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseData { response in
            if let data = response.data {
                var sources = [NewsSource]()
                let json = JSON(data)
                if json["status"].stringValue == "ok" {
                    for jsn in json["sources"].arrayValue {
                        let source = NewsSource(json: jsn)
                        sources.append(source)
                    }
                    completion(sources)
                } else {
                    completion(nil)
                }
                
            } else {
                completion(nil)
            }
        }
    }
    
    // MARK: Get News item from articles endpoint
    class func getNewsItems(_ source: String, completion: @escaping (_ data: [News]?) -> Void) {
        
        let newsItemsUrl = ApiDefaults.baseUrl + ApiDefaults.headlinesPath + "?sources=\(source)" + "&apiKey=" + ApiDefaults.apiKey
        
        Alamofire.request(newsItemsUrl, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseData { response in
            if let data = response.data {
                var items = [News]()
                let json = JSON(data)
                if json["status"].stringValue == "ok" {
                    for jsn in json["articles"].arrayValue {
                        let source = News(json: jsn)
                        items.append(source)
                    }
                    completion(items)
                } else {
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
}
