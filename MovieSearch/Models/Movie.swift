//
//  Movie.swift
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

class Movie {

    // The movie title
    var title = ""

    /// The original movie title
    var originalTitle = ""

    /// Number of votes given by user to movie
    var voteCount = 0
    
    /// Unique movie identifier for movie
    var movieId = 0
    
    /// `true` when video available else `false`
    var video = false
    
    /// The average vote given by user
    var voteAverage = 0.0
    
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
    
    /// The Movie release date
    var releaseDate: Date?
    
    /// The Movie release date in string format
    var releaseDateString: String?
    
    /// Set `true` when image downloading is in progress
    var isDownloadingInProgress = false
    
    /// Creates instance of `Movie`
    ///
    /// - Parameter dictionary: The name of movie
    init(dictionary: [String: AnyObject]) {
        self.title = dictionary[MovieResultKey.title] as? String ?? self.title
        self.originalTitle = dictionary[MovieResultKey.originalTitle] as? String ?? self.originalTitle
        self.overview = dictionary[MovieResultKey.overview] as? String
        self.voteCount = dictionary[MovieResultKey.voteCount] as? Int ?? self.voteCount
        self.movieId = dictionary[MovieResultKey.movieId] as? Int ?? self.movieId
        self.voteAverage = dictionary[MovieResultKey.voteAverage] as? Double ?? self.voteAverage
        self.popularity = dictionary[MovieResultKey.popularity] as? Double ?? self.popularity
        self.video = dictionary[MovieResultKey.video] as? Bool ?? self.video
        self.adult = dictionary[MovieResultKey.adult] as? Bool ?? self.adult
        self.genreIds = dictionary[MovieResultKey.genreIds] as? [Int]
        self.posterPath = dictionary[MovieResultKey.posterPath] as? String
        self.backdropPath = dictionary[MovieResultKey.backdropPath] as? String
        if let releaseDateString = dictionary[MovieResultKey.releaseDate] as? String {
            self.releaseDate = Date.dateFromString(dateString: releaseDateString)
            if let releaseDate = self.releaseDate {
                self.releaseDateString = Date.stringFromDate(date: releaseDate)
            }
        }
    }
}
