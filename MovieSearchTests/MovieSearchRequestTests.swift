//
//  MovieSearchRequestTests.swift
//  MovieSearchTests
//
//  Created by Ganesh on 2/17/18.
//  Copyright © 2018 Ganesh. All rights reserved.
//

import XCTest

@testable import MovieSearch

class MovieSearchRequestTests: XCTestCase {
    
    func testMovieSearchRequestInit() {
        let request = MovieSearchRequest(searchKey: "searchKey", pageNumber: 1)
        XCTAssertEqual(request.searchKey, "searchKey")
        XCTAssertEqual(request.pageNumber, 1)
    }
    
    func testStringByAppendingAllParameters() {
        let request = MovieSearchRequest(searchKey: "searchKey", pageNumber: 1)
        let urlString = request.stringByAppendingAllParameters()
        XCTAssertEqual(urlString, "api_key=2696829a81b1b5827d515ff121700838&query=searchKey&page=1")
    }
}
