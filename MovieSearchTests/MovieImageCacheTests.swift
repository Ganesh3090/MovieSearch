//
//  MovieImageCacheTests.swift
//  MovieSearchTests
//
//  Created by Ganesh on 2/18/18.
//  Copyright © 2018 Ganesh. All rights reserved.
//

import XCTest

@testable import MovieSearch

class MovieImageCacheTests: XCTestCase {
    
    override func setUp() {
        super.setUp()

        MovieImageCache.shared.removeAllObjects()
    }
    
    override func tearDown() {
        MovieImageCache.shared.removeAllObjects()
        super.tearDown()
    }
    
    func testImageCashing() {
        let image = UIImage()
        let imageUrlString = "myImagePath"
        
        MovieImageCache.shared.cacheImage(image: image, urlString: imageUrlString)
        XCTAssertEqual(MovieImageCache.shared.imageForUrl(urlString: imageUrlString), image)
    }
    
    func testRemoveAllObjects() {
        let image = UIImage()
        let imageUrlString = "myImagePath"
        
        MovieImageCache.shared.cacheImage(image: image, urlString: imageUrlString)
        MovieImageCache.shared.removeAllObjects()
        XCTAssertNil(MovieImageCache.shared.imageForUrl(urlString: imageUrlString))
    }
    
}
