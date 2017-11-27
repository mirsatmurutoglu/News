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
    class func getNewsSources(completion: @escaping (_ data: [NewsSource]?, _ error: String?) -> Void) {
        
        let newsSourcesUrl = ApiDefaults.baseUrl + "sources?apiKey=" + ApiDefaults.apiKey
        
        Alamofire.request(newsSourcesUrl, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseData { response in
            if let data = response.data {
                var sources = [NewsSource]()
                let json = JSON(data)
                for jsn in json["sources"].arrayValue {
                    let source = NewsSource(json: jsn)
                    sources.append(source)
                }
                completion(sources, nil)
            } else {
                completion(nil, "no news")
            }
        }
    }
}
