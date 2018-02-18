//
//  MovieTests.swift
//  MovieSearchTests
//
//  Created by Ganesh on 2/17/18.
//  Copyright © 2018 Ganesh. All rights reserved.
//

import XCTest

@testable import MovieSearch

class MovieTests: XCTestCase {
    
    func testInit() {
        let dictionry = [MovieResultKey.title: "Movie1",
                         MovieResultKey.originalTitle: "",
                         MovieResultKey.voteCount: 123,
                         MovieResultKey.voteAverage: 12,
                         MovieResultKey.movieId: 13,
                         MovieResultKey.video: true,
                         MovieResultKey.popularity: 1.1,
                         MovieResultKey.adult: true,
                         MovieResultKey.originalLanguage: "en",
                         MovieResultKey.posterPath: "posterPath",
                         MovieResultKey.backdropPath: "backdropPath",
                         MovieResultKey.genreIds: [1,2,4]] as [String : AnyObject]
        
        let movie = Movie(dictionary: dictionry)
        
        XCTAssertEqual(movie.title, "Movie1")
        XCTAssertEqual(movie.originalTitle, "")
        XCTAssertEqual(movie.voteCount, 123)
        XCTAssertEqual(movie.movieId, 13)
        XCTAssertEqual(movie.video, true)
        XCTAssertEqual(movie.voteAverage, 12)
        XCTAssertEqual(movie.popularity, 1.1)
        XCTAssertEqual(movie.adult, true)
        XCTAssertEqual(movie.originalLanguage, .unknown)
        
        XCTAssertEqual(movie.posterPath, "posterPath")
        XCTAssertEqual(movie.backdropPath, "backdropPath")
        XCTAssertEqual(movie.genreIds?.count, [1,2,4].count)
    }
    
    func testInitWithMismatchType() {
        let dictionry = [MovieResultKey.title: 1,
                         MovieResultKey.originalTitle: 1,
                         MovieResultKey.voteCount: "123",
                         MovieResultKey.voteAverage: "12",
                         MovieResultKey.movieId: "13",
                         MovieResultKey.video: "true",
                         MovieResultKey.popularity: "1.1",
                         MovieResultKey.adult: "true",
                         MovieResultKey.originalLanguage: 1,
                         MovieResultKey.posterPath: 1,
                         MovieResultKey.backdropPath: 1,
                         MovieResultKey.genreIds: "123"] as [String : AnyObject]
        
        let movie = Movie(dictionary: dictionry)
        
        XCTAssertEqual(movie.title, "")
        XCTAssertEqual(movie.originalTitle, "")
        XCTAssertEqual(movie.voteCount, 0)
        XCTAssertEqual(movie.movieId, 0)
        XCTAssertEqual(movie.video, false)
        XCTAssertEqual(movie.voteAverage, 0)
        XCTAssertEqual(movie.popularity, 0.0)
        XCTAssertEqual(movie.adult, false)
        XCTAssertEqual(movie.originalLanguage, .unknown)
        
        XCTAssertNil(movie.posterPath)
        XCTAssertNil(movie.backdropPath)
        XCTAssertNil(movie.genreIds)
    }
    
    func testDefaultValues() {
        
        let movie = Movie(dictionary: ["title": "Movie1" as AnyObject])
        
        XCTAssertEqual(movie.title, "Movie1")
        XCTAssertEqual(movie.originalTitle, "")
        XCTAssertEqual(movie.voteCount, 0)
        XCTAssertEqual(movie.movieId, 0)
        XCTAssertEqual(movie.video, false)
        XCTAssertEqual(movie.voteAverage, 0)
        XCTAssertEqual(movie.popularity, 0.0)
        XCTAssertEqual(movie.adult, false)
        XCTAssertEqual(movie.originalLanguage, .unknown)

        XCTAssertNil(movie.posterPath)
        XCTAssertNil(movie.backdropPath)
        XCTAssertNil(movie.genreIds)
    }
}
