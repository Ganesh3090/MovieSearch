//
//  DataParser.swift
//  MovieSearch
//
//  Created by Ganesh on 2/17/18.
//  Copyright © 2018 Ganesh. All rights reserved.
//

import Foundation

struct MovieListKey {
    static let pageNamber = "page"
    static let totalPages = "total_pages"
    static let totalResult = "total_results"
    static let results = "results"
    static let statusCode = "status_code"
    
    // Prevent init
    private init() { }
}

struct MovieResultKey {
    
    static let voteCount = "vote_count"
    static let movieId = "id"
    static let video = "video"
    static let voteAverage = "vote_average"
    static let title = "title"
    static let popularity = "popularity"
    static let posterPath = "poster_path"
    static let originalLanguage = "original_language"
    static let originalTitle = "original_title"
    static let genreIds = "genre_ids"
    static let backdropPath = "backdrop_path"
    static let adult = "adult"
    static let overview = "overview"
    static let releaseDate = "release_date"
    
    // Prevent init
    private init() { }
}

class DataParser: NSObject {
    
    // MARK: - Methods
    
    /// Parse the json data and convert JSON data into `Movie` array
    ///
    /// - Parameter data: The JSON data
    /// - Returns: `MovieList` if valid JSON data for movie details
    class func parseMovieSearchJSONData(data: Data) -> MovieList? {
        do {
            guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] else {
                print("Error while parsing the JSON data")
                return nil
            }
            
            return MovieList(dictionary: json)
            
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
        
        return nil
    }
}
