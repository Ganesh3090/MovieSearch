//
//  MovieSearchManagerTests.swift
//  MovieSearchTests
//
//  Created by Ganesh on 2/18/18.
//  Copyright © 2018 Ganesh. All rights reserved.
//

import XCTest

@testable import MovieSearch

class MovieSearchManagerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        MovieSearchManager.shared.searchResult = nil
    }
    
    override func tearDown() {
        MovieSearchManager.shared.resetSearchResult()
        super.tearDown()
    }
    
    func testNumberOfPages() {
        let manager = MovieSearchManager.shared
        
        // Test default value
        XCTAssertEqual(manager.numberOfPages, 1)
        
        var searchResult = MovieSearchResult()
        searchResult.numberOfPages = 10
        manager.searchResult = searchResult
        XCTAssertEqual(manager.numberOfPages, 10)
    }
    
    func testNextPageAvaiable() {
        let manager = MovieSearchManager.shared
        
        var searchResult = MovieSearchResult()
        searchResult.numberOfPages = 10
        manager.searchResult = searchResult
        
        manager.currentPage = 0
        XCTAssertTrue(manager.nextPageAvaiable())
        
        searchResult.numberOfPages = 10
        manager.searchResult = searchResult
        
        manager.currentPage = 10
        XCTAssertFalse(manager.nextPageAvaiable())
    }
    
    func testResetSearchResult() {
        let manager = MovieSearchManager.shared
        var searchResult = MovieSearchResult()
        searchResult.numberOfPages = 10
        manager.searchResult = searchResult
        manager.currentSearchText = "Any Text"
        
        manager.resetSearchResult()
        
        XCTAssertEqual(manager.currentPage, 1)
        XCTAssertEqual(manager.numberOfPages, 1)
        XCTAssertEqual(manager.currentSearchText, "")
        XCTAssertNil(manager.searchResult)
    }
    
    func testAddSearchResult() {
        let manager = MovieSearchManager.shared
        
        var oldResult = MovieSearchResult()
        let movie1 = Movie(title: "Movie1")
        let movie2 = Movie(title: "Movie2")
        oldResult.results = [movie1, movie2]
        
        manager.searchResult = oldResult
        
        var newResult = MovieSearchResult()
        let movie3 = Movie(title: "Movie3")
        let movie4 = Movie(title: "Movie4")
        newResult.results = [movie3, movie4]
        
        manager.addSearchResult(searchResult: newResult)
        
        guard let movieList = manager.searchResult?.results,
            movieList.count == 4 else {
                XCTFail()
                return
        }
        
        XCTAssertEqual(movieList[0].title, movie1.title)
        XCTAssertEqual(movieList[1].title, movie2.title)
        XCTAssertEqual(movieList[2].title, movie3.title)
        XCTAssertEqual(movieList[3].title, movie4.title)
    }
    
    func testAddSearchResultWithNilResult() {
        let manager = MovieSearchManager.shared
        
        var newResult = MovieSearchResult()
        let movie1 = Movie(title: "Movie1")
        let movie2 = Movie(title: "Movie2")
        newResult.results = [movie1, movie2]
        
        manager.addSearchResult(searchResult: newResult)
        
        guard let movieList = manager.searchResult?.results,
            movieList.count == 2 else {
                XCTFail()
                return
        }
        
        XCTAssertEqual(movieList[0].title, movie1.title)
        XCTAssertEqual(movieList[1].title, movie2.title)
    }
    
    func testAddSearchResultWithNilList() {
        let manager = MovieSearchManager.shared
        
        var oldResult = MovieSearchResult()
        let movie1 = Movie(title: "Movie1")
        let movie2 = Movie(title: "Movie2")
        oldResult.results = [movie1, movie2]
        
        manager.searchResult = oldResult
        let newResult = MovieSearchResult()
        
        manager.addSearchResult(searchResult: newResult)
        
        guard let movieList = manager.searchResult?.results,
            movieList.count == 2 else {
                XCTFail()
                return
        }
        
        XCTAssertEqual(movieList[0].title, movie1.title)
        XCTAssertEqual(movieList[1].title, movie2.title)
    }
}
