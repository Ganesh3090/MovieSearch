//
//  MovieListTests.swift
//  MovieSearchTests
//
//  Created by Ganesh on 2/18/18.
//  Copyright © 2018 Ganesh. All rights reserved.
//

import XCTest

@testable import MovieSearch

class MovieListTests: XCTestCase {
    
    func testInit() {
        let dictionry = [MovieListKey.totalPages: 3,
                         MovieListKey.pageNamber: 2,
                         MovieListKey.totalResult: 100,
                         MovieListKey.results: ""] as [String : AnyObject]
        
        let list = MovieList(dictionary: dictionry)
        XCTAssertEqual(list.numberOfPages, 3)
        XCTAssertEqual(list.pageNumber, 2)
        XCTAssertEqual(list.totalResult, 100)
        XCTAssertNil(list.results)
        XCTAssertNil(list.statusCode)
    }
    
    func testDefaultValues() {
        let list = MovieList(dictionary: nil)
        
        XCTAssertEqual(list.numberOfPages, 1)
        XCTAssertEqual(list.pageNumber, 1)
        XCTAssertEqual(list.totalResult, 0)
        XCTAssertNil(list.results)
        XCTAssertNil(list.statusCode)
    }
    
    func testInitWithMovieList() {
        let movie = ["title": "Movie1" as AnyObject]
        let dictionry = [MovieListKey.totalPages: 3,
                         MovieListKey.pageNamber: 2,
                         MovieListKey.totalResult: 100,
                         MovieListKey.results: [movie]] as [String : AnyObject]
        
        let list = MovieList(dictionary: dictionry)
        XCTAssertEqual(list.numberOfPages, 3)
        XCTAssertEqual(list.pageNumber, 2)
        XCTAssertEqual(list.totalResult, 100)
        XCTAssertEqual(list.results?.count, 1)
        XCTAssertNil(list.statusCode)
    }
    
    func testInitWithStatusCode() {
        let dictionry = [MovieListKey.totalPages: 3,
                         MovieListKey.pageNamber: 2,
                         MovieListKey.totalResult: 100,
                         MovieListKey.statusCode: 7,
                         MovieListKey.results: ""] as [String : AnyObject]
        
        let list = MovieList(dictionary: dictionry)
        XCTAssertEqual(list.numberOfPages, 1)
        XCTAssertEqual(list.pageNumber, 1)
        XCTAssertEqual(list.totalResult, 0)
        XCTAssertEqual(list.statusCode, 7)
        XCTAssertNil(list.results)
    }
    
    func testInitMismatchingValues() {
        let dictionry = [MovieListKey.totalPages: "",
                         MovieListKey.pageNamber: "",
                         MovieListKey.totalResult: "",
                         MovieListKey.results: 1] as [String : AnyObject]
        
        let list = MovieList(dictionary: dictionry)
        XCTAssertEqual(list.numberOfPages, 0)
        XCTAssertEqual(list.pageNumber, 0)
        XCTAssertEqual(list.totalResult, 0)
        XCTAssertNil(list.results)
        XCTAssertNil(list.statusCode)
    }
}
