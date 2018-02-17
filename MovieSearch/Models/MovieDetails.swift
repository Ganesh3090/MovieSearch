//
//  MovieDetails.swift
//  MovieSearch
//
//  Created by Ganesh on 2/17/18.
//  Copyright © 2018 Ganesh. All rights reserved.
//

import Foundation

enum MovieLanguage: String {
    case english = "en"
    case turki = "tr"
    case unknown = "unknown"
}

struct MovieDetails {

    // The movie title
    var title: String

    /// The original movie title
    var originalTitle = ""

    /// Number of votes given by user to movie
    var votCount = 0
    
    /// Unique movie identifier for movie
    var moviewId = 0
    
    /// `true` when video available else `false`
    var video = false
    
    /// The average vote given by user
    var voteAverage = 0
    
    /// Popularity of movie
    var popularity = 0.0

    /// `true` if movie restricted to childrens else `false`
    var adult = false
    
    /// The genre IDs
    var genreIds: [Int]?
    
    /// Description of a movie
    var overview: String?
    
    /// `URL` path to download the movie poster
    var posterPath: String?
    
    /// `URL` path to download movie banner
    var backdropPath: String?
    
    /// The original language of movie
    var originalLanguage = MovieLanguage.unknown
    
    /// Creates instance of `MovieDetails`
    ///
    /// - Parameter title: The name of movie
    init(title: String) {
        self.title = title
    }
}
