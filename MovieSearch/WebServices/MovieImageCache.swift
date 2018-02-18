//
//  MovieImageCache.swift
//  MovieSearch
//
//  Created by Ganesh on 2/18/18.
//  Copyright © 2018 Ganesh. All rights reserved.
//

import UIKit

class MovieImageCache {

    static let shared = MovieImageCache()
    
    let imageCache = NSCache<NSString, UIImage>()

    private init() { }
    
    func imageForUrl(urlString: String) -> UIImage? {
        return self.imageCache.object(forKey: urlString as NSString)
    }
    
    func cacheImage(image: UIImage, urlString: String) {
        self.imageCache.setObject(image, forKey: urlString as NSString)
    }
}
