//
//  MovieDetailsTests.swift
//  MovieSearchTests
//
//  Created by Ganesh on 2/17/18.
//  Copyright © 2018 Ganesh. All rights reserved.
//

import XCTest

@testable import MovieSearch

class MovieDetailsTests: XCTestCase {
    
    func testMovieDetailsInit() {
        
        let movie = MovieDetails(title: "title")
        
        XCTAssertEqual(movie.title, "title")
    }
    
    func testDefaultValues() {
        
        let movie = MovieDetails(title: "title")
        
        XCTAssertEqual(movie.title, "title")
        XCTAssertEqual(movie.originalTitle, "")
        XCTAssertEqual(movie.votCount, 0)
        XCTAssertEqual(movie.moviewId, 0)
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
