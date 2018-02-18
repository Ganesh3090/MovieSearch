//
//  DataParserTests.swift
//  MovieSearchTests
//
//  Created by Ganesh on 2/18/18.
//  Copyright © 2018 Ganesh. All rights reserved.
//

import XCTest

@testable import MovieSearch

class DataParserTests: XCTestCase {
    
    private static let mockData = "{\"page\":1,\"total_results\":105,\"total_pages\":6,\"results\":[{\"vote_count\":2575,\"id\":268,\"video\":false,\"vote_average\":7,\"title\":\"Batman\",\"popularity\":26.22,\"poster_path\":\"/kBf3g9crrADGMc2AMAMlLBgSm2h.jpg\",\"original_language\":\"en\",\"original_title\":\"Batman\",\"genre_ids\":[14,28],\"backdrop_path\":\"/2blmxp2pr4BhwQr74AdCfwgfMOb.jpg\",\"adult\":true,\"overview\":\"movieoverview\",\"release_date\":\"1989-06-23\"}]}"
    
    private static let invalidMockData = "{\"page\":1,\"total_results\":105,\"total_pages\":6,\"results\":[{\"vote_count\":\"2\",\"id\":\"2\",\"video\":\"false\",\"vote_average\":\"2\",\"title\":1,\"popularity\":\"2\",\"poster_path\":\"/kBf3g9crrADGMc2AMAMlLBgSm2h.jpg\",\"original_language\":\"en\",\"original_title\":1,\"genre_ids\":[14,28],\"backdrop_path\":\"/2blmxp2pr4BhwQr74AdCfwgfMOb.jpg\",\"adult\":\"false\",\"overview\":1,\"release_date\":\"1989-06-23\"}]}"

    func testParseMovieSearchJSONDataWithEmptyData() {
        let invalidJsonData = Data()
        XCTAssertNil(DataParser.parseMovieSearchJSONData(data: invalidJsonData))
    }
    
    func testParseMovieSearchJSONDataWithInvalidData() {
        let invalidJsonData = "[]".data(using: String.Encoding.utf8)
        XCTAssertNil(DataParser.parseMovieSearchJSONData(data: invalidJsonData!))
    }
    
    func testParseMovieSearchJSONDataWithStatusCode() {
        let invalidJsonData = "{\"status_code\":105}".data(using: String.Encoding.utf8)
        let result = DataParser.parseMovieSearchJSONData(data: invalidJsonData!)
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.statusCode, 105)
        XCTAssertEqual(result?.pageNumber, 1)
        XCTAssertEqual(result?.numberOfPages, 1)
        XCTAssertEqual(result?.totalResult, 0)
        XCTAssertNil(result?.results)
    }
    
    func testParseMovieSearchJSONDataWithNilList() {
        let invalidJsonData = "{\"page\":1,\"total_results\":105,\"total_pages\":6,\"results\":\"\"}".data(using: String.Encoding.utf8)
        let result = DataParser.parseMovieSearchJSONData(data: invalidJsonData!)
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.statusCode, nil)
        XCTAssertEqual(result?.pageNumber, 1)
        XCTAssertEqual(result?.numberOfPages, 6)
        XCTAssertEqual(result?.totalResult, 105)
        XCTAssertNil(result?.results)
    }
    
    func testParseMovieSearchJSONDataWithInvalidPageNumber() {
        let invalidJsonData = "{\"page\":\"1\",\"total_results\":\"105\",\"total_pages\":\"6\",\"results\":\"\"}".data(using: String.Encoding.utf8)
        let result = DataParser.parseMovieSearchJSONData(data: invalidJsonData!)
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.statusCode, nil)
        XCTAssertEqual(result?.pageNumber, 0)
        XCTAssertEqual(result?.numberOfPages, 0)
        XCTAssertEqual(result?.totalResult, 0)
        XCTAssertNil(result?.results)
    }
    
    func testParseMovieSearchJSONDataWithEmptyList() {
        let invalidJsonData = "{\"page\":1,\"total_results\":105,\"total_pages\":6,\"results\":[]}".data(using: String.Encoding.utf8)
        let result = DataParser.parseMovieSearchJSONData(data: invalidJsonData!)
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.statusCode, nil)
        XCTAssertEqual(result?.pageNumber, 1)
        XCTAssertEqual(result?.numberOfPages, 6)
        XCTAssertEqual(result?.totalResult, 105)
        XCTAssertEqual(result?.results?.count, 0)
    }
    
    func testParseMovieSearchJSONDataWithValidMovieDetails() {
        let invalidJsonData = type(of: self).mockData.data(using: String.Encoding.utf8)
        let result = DataParser.parseMovieSearchJSONData(data: invalidJsonData!)
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.statusCode, nil)
        XCTAssertEqual(result?.pageNumber, 1)
        XCTAssertEqual(result?.numberOfPages, 6)
        XCTAssertEqual(result?.totalResult, 105)
        XCTAssertEqual(result?.results?.count, 1)
        
        guard let movie = result?.results?.first else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(movie.title, "Batman")
        XCTAssertEqual(movie.originalTitle, "Batman")
        XCTAssertEqual(movie.overview, "movieoverview")
        XCTAssertEqual(movie.voteCount, 2575)
        XCTAssertEqual(movie.movieId, 268)
        XCTAssertEqual(movie.video, false)
        XCTAssertEqual(movie.voteAverage, 7)
        XCTAssertEqual(movie.popularity, 26.22)
        XCTAssertEqual(movie.adult, true)
        XCTAssertEqual(movie.originalLanguage, .unknown)
        
        XCTAssertEqual(movie.posterPath, "/kBf3g9crrADGMc2AMAMlLBgSm2h.jpg")
        XCTAssertEqual(movie.backdropPath, "/2blmxp2pr4BhwQr74AdCfwgfMOb.jpg")
        XCTAssertEqual(movie.genreIds!, [14,28])
    }

    func testParseMovieSearchJSONDataWithInvalidMovieDetails() {
        let invalidJsonData = type(of: self).invalidMockData.data(using: String.Encoding.utf8)
        let result = DataParser.parseMovieSearchJSONData(data: invalidJsonData!)
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.statusCode, nil)
        XCTAssertEqual(result?.pageNumber, 1)
        XCTAssertEqual(result?.numberOfPages, 6)
        XCTAssertEqual(result?.totalResult, 105)
        XCTAssertEqual(result?.results?.count, 1)
        
        guard let movie = result?.results?.first else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(movie.title, "")
        XCTAssertEqual(movie.originalTitle, "")
        XCTAssertNil(movie.overview)
        XCTAssertEqual(movie.voteCount, 0)
        XCTAssertEqual(movie.movieId, 0)
        XCTAssertEqual(movie.video, false)
        XCTAssertEqual(movie.voteAverage, 0)
        XCTAssertEqual(movie.popularity, 0.0)
        XCTAssertEqual(movie.adult, false)
        XCTAssertEqual(movie.originalLanguage, .unknown)
        
        XCTAssertEqual(movie.posterPath, "/kBf3g9crrADGMc2AMAMlLBgSm2h.jpg")
        XCTAssertEqual(movie.backdropPath, "/2blmxp2pr4BhwQr74AdCfwgfMOb.jpg")
        XCTAssertEqual(movie.genreIds!, [14,28])
    }

}
