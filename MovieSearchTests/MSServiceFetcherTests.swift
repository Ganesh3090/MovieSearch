//
//  MSServiceFetcherTests.swift
//  MovieSearchTests
//
//  Created by Ganesh on 2/18/18.
//  Copyright © 2018 Ganesh. All rights reserved.
//

import XCTest

@testable import MovieSearch

struct ExpectationConstant {
    static let timeout = 5.0
}

class URLSessionDataTaskMock: URLSessionDataTask {
    
    override func resume() {
        
    }
}

class URLSessionMock: URLSession {
    
    var methodExcuted = false
    var sessionTask: URLSessionDataTaskMock!
    var data: Data?
    var response: URLResponse?
    var error: Error?
    
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        self.methodExcuted = true
        completionHandler(self.data, self.response, self.error)
        return self.sessionTask
    }
}

class MSServiceFetcherTests: XCTestCase {
    
    private var defaultSession: URLSessionMock!
    private var serviceFetcher: MSServiceFetcher!
    private var dataTask: URLSessionDataTaskMock!

    private static let mockData = "{\"page\":1,\"total_results\":105,\"total_pages\":6,\"results\":[{\"vote_count\":2575,\"id\":268,\"video\":false,\"vote_average\":7,\"title\":\"Batman\",\"popularity\":26.091895,\"poster_path\":\"/kBf3g9crrADGMc2AMAMlLBgSm2h.jpg\",\"original_language\":\"en\",\"original_title\":\"Batman\",\"genre_ids\":[14,28],\"backdrop_path\":\"/2blmxp2pr4BhwQr74AdCfwgfMOb.jpg\",\"adult\":false,\"overview\":\"The Dark Knight of Gotham City begins his war on crime with his first major enemy being the clownishly homicidal Joker, who has seized control of Gotham's underworld.\",\"release_date\":\"1989-06-23\"},{\"vote_count\":257,\"id\":2661,\"video\":false,\"vote_average\":6.1,\"title\":\"Batman\",\"popularity\":9.224053,\"poster_path\":\"/udDVJXtAFsQ8DimrXkVFqy4DGEQ.jpg\",\"original_language\":\"en\",\"original_title\":\"Batman\",\"genre_ids\":[10751,12,35,878,80],\"backdrop_path\":\"/5gcdof2PKH1emllBdN1VXU706IP.jpg\",\"adult\":false,\"overview\":\"The Dynamic Duo faces four super-villains who plan to hold the world for ransom with the help of a secret invention that instantly dehydrates people.\",\"release_date\":\"1966-07-30\"}]}"
    
    override func setUp() {
        super.setUp()

        self.serviceFetcher = MSServiceFetcher()
        self.defaultSession = URLSessionMock()
        self.dataTask = URLSessionDataTaskMock()
        self.defaultSession.sessionTask = self.dataTask
        self.serviceFetcher.defaultSession = self.defaultSession
    }
    
    override func tearDown() {
        self.serviceFetcher = nil
        self.defaultSession = nil
        super.tearDown()
    }
    
    func testFetchSearchResultForInvalidURL() {
        let request = MovieSearchRequest(searchKey: "title", pageNumber: 1)
        self.serviceFetcher.baseURL = "Invalid URL string"
        
        self.serviceFetcher.fetchSearchResult(request: request) { (result) in
            XCTFail()
        }
        XCTAssertEqual(self.defaultSession.methodExcuted, false)
    }
    
    func testFetchSearchResultForServerError() {
        
        self.defaultSession.error = NSError(domain: "HttpResponseErrorDomain", code: 44, userInfo: nil)
        let request = MovieSearchRequest(searchKey: "title", pageNumber: 1)
        
        let expectation = self.expectation(description: "Expectation Testing asynchronous block")

        self.serviceFetcher.fetchSearchResult(request: request) { (result) in
            XCTAssertNil(result)
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: ExpectationConstant.timeout)
    }
    
    func testFetchSearchResultForEmptyData() {
        
        let request = MovieSearchRequest(searchKey: "title", pageNumber: 1)
        
        let expectation = self.expectation(description: "Expectation Testing asynchronous block")
        
        self.serviceFetcher.fetchSearchResult(request: request) { (result) in
            XCTAssertNil(result)
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: ExpectationConstant.timeout)
    }
    
    func testFetchSearchResultForValidData() {
        
        self.defaultSession.data = type(of: self).mockData.data(using: String.Encoding.utf8)
        let request = MovieSearchRequest(searchKey: "title", pageNumber: 1)
        
        let expectation = self.expectation(description: "Expectation Testing asynchronous block")
        
        self.serviceFetcher.fetchSearchResult(request: request) { (result) in
            XCTAssertNotNil(result)
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: ExpectationConstant.timeout)
    }
}
