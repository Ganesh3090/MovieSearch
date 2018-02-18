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
    
    func testMovieInit() {
        
        let movie = Movie(title: "title")
        
        XCTAssertEqual(movie.title, "title")
    }
    
    func testDefaultValues() {
        
        let movie = Movie(title: "title")
        
        XCTAssertEqual(movie.title, "title")
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
