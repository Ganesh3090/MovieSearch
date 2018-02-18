//
//  DataParser.swift
//  MovieSearch
//
//  Created by Ganesh on 2/17/18.
//  Copyright © 2018 Ganesh. All rights reserved.
//

import Foundation

struct SearchResultKey {
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
    /// - Returns: `MovieSearchResult` if valid JSON data for movie details
    class func parseMovieSearchJSONData(data: Data) -> MovieSearchResult? {
     
        do {
            guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] else {
                print("Error while parsing the JSON data")
                return nil
            }
            
            var result = MovieSearchResult()
            
            result.statusCode = json[SearchResultKey.statusCode] as? Int

            if result.statusCode != nil {
                /// Something went wrong. Like invalid API key
                return result
            }
            
            result.numberOfPages = json[SearchResultKey.totalPages] as? Int ?? 0
            result.pageNumber = json[SearchResultKey.pageNamber] as? Int ?? 0
            result.totalResult = json[SearchResultKey.totalResult] as? Int ?? 0

            guard let movieList = json[SearchResultKey.results] as? [[String: AnyObject]] else {
                return result
            }
            
            var moviewResults: [Movie] = []
            for movieItem in movieList {
                var movie = Movie(title: "")
                
                movie.title = movieItem[MovieResultKey.title] as? String ?? movie.title
                movie.originalTitle = movieItem[MovieResultKey.originalTitle] as? String ?? movie.originalTitle
                movie.overview = movieItem[MovieResultKey.overview] as? String
                movie.voteCount = movieItem[MovieResultKey.voteCount] as? Int ?? movie.voteCount
                movie.movieId = movieItem[MovieResultKey.movieId] as? Int ?? movie.movieId
                movie.voteAverage = movieItem[MovieResultKey.voteAverage] as? Double ?? movie.voteAverage
                movie.popularity = movieItem[MovieResultKey.popularity] as? Double ?? movie.popularity
                movie.video = movieItem[MovieResultKey.video] as? Bool ?? movie.video
                movie.adult = movieItem[MovieResultKey.adult] as? Bool ?? movie.adult
                movie.genreIds = movieItem[MovieResultKey.genreIds] as? [Int]
                movie.posterPath = movieItem[MovieResultKey.posterPath] as? String
                movie.backdropPath = movieItem[MovieResultKey.backdropPath] as? String
                movie.releaseDate = movieItem[MovieResultKey.releaseDate] as? String

                moviewResults.append(movie)
            }
            
            result.results = moviewResults
            
            return result
            
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
        
        return nil
    }
}
