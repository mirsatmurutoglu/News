//
//  ImageLoader.swift
//  ZKCarousel_Example
//
//  Created by Mirsat Murutoglu on 30/11/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

//
//  ImageView+AsyncLoad.swift
//  mym1usagetracker
//
//  Created by zupao on 30/12/15.
//  Copyright © 2015 m1. All rights reserved.
//
import Foundation
import UIKit

var imageCache = NSCache<AnyObject, AnyObject>()// caching the images

class ImageLoader {

    ///
    /// static method to load UIImage from url asynchronously
    ///
    class func loadImageFromUrl(_ urlString: String, callback: @escaping (_ image:UIImage?, _ url:String)->Void){

        if let image = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            callback(image, urlString)
        } else {
            DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
                guard let url = URL(string: urlString) else {
                    callback(nil, urlString)
                    return
                }
                let imageData = try? Data(contentsOf: url)
                if let data = imageData {
                    imageCache.setObject(UIImage(data: data)!, forKey: urlString as AnyObject)
                    DispatchQueue.main.async(execute: {
                        if let image = UIImage(data: data) {
                            callback(image, urlString)
                        }
                    })
                }
            }
        }
    }
}
