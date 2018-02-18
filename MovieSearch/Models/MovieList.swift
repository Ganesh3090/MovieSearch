//
//  MovieList.swift
//  MovieSearch
//
//  Created by Ganesh on 2/18/18.
//  Copyright © 2018 Ganesh. All rights reserved.
//

import UIKit

struct MovieList {

    // MARK: - Variables

    /// Current page of the result
    var pageNumber = 1
    
    /// Total number pages available in the search
    var numberOfPages = 1

    /// The total result for a search
    var totalResult = 0
    
    /// The result of the current page
    var results: [Movie]?
    
    /// The status code if there is any error
    var statusCode: Int?
    
    // MARK: - Initializer

    init(dictionary: [String: AnyObject]?) {
        guard let dictionary = dictionary else { return }
        
        self.statusCode = dictionary[MovieListKey.statusCode] as? Int
        
        if self.statusCode != nil {
            /// Something went wrong. Like invalid API key
            return
        }
        
        self.numberOfPages = dictionary[MovieListKey.totalPages] as? Int ?? 0
        self.pageNumber = dictionary[MovieListKey.pageNamber] as? Int ?? 0
        self.totalResult = dictionary[MovieListKey.totalResult] as? Int ?? 0
        
        guard let movieList = dictionary[MovieListKey.results] as? [[String: AnyObject]] else {
            return
        }
        
        var moviewResults: [Movie] = []
        
        for movieItem in movieList {
            moviewResults.append(Movie(dictionary: movieItem))
        }
        self.results = moviewResults
    }
}
