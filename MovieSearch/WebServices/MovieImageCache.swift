//
//  MovieImageCache.swift
//  MovieSearch
//
//  Created by Ganesh on 2/18/18.
//  Copyright © 2018 Ganesh. All rights reserved.
//

import UIKit

class MovieImageCache {

    // MARK: - Variables

    static let shared = MovieImageCache()
    
    let imageCache = NSCache<NSString, UIImage>()

    // MARK: - Initializer

    private init() { }

    // MARK: - Methods

    /// Returns `UIImage` if image found in caache else returns `nil`
    ///
    /// - Parameter urlString: Unique url string used as key to retrive the image
    /// - Returns: Instance of `UIImage`
    func imageForUrl(urlString: String) -> UIImage? {
        return self.imageCache.object(forKey: urlString as NSString)
    }
    
    /// Chache the `UIImage` for the given url string
    ///
    /// - Parameters:
    ///   - image: The image which needs to cache
    ///   - urlString: Unique key used to chache image
    func cacheImage(image: UIImage, urlString: String) {
        self.imageCache.setObject(image, forKey: urlString as NSString)
    }
    
    /// Removed the all objects from the cache
    func removeAllObjects() {
        self.imageCache.removeAllObjects()
    }
}
