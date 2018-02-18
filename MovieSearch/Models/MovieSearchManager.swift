//
//  MovieSearchManager.swift
//  MovieSearch
//
//  Created by Ganesh on 2/18/18.
//  Copyright © 2018 Ganesh. All rights reserved.
//

import UIKit

class MovieSearchManager {

    // MARK: - Variables

    /// Shared instance to handle the movie search
    static let shared = MovieSearchManager()
    
    /// returns the total movies list
    var movieResult: [Movie] {
        return self.searchResult?.results ?? []
    }
    
    /// Holds the rescent searches
    var rescentSearches: [String] = []
    
    /// Holds the index of page which downloaded recently
    var currentPage = 1
    
    /// Hold the test searched by user
    var currentSearchText = ""

    /// Number movie pages for the search
    var numberOfPages: Int {
        return self.searchResult?.numberOfPages ?? 1
    }
    
    /// Holds the rescent serach result
    var searchResult: MovieSearchResult?
    
    // MARK: - Intializer

    private init() { }
    
    // MARK: - Methods

    /// Finds the the next page available for to fetch
    ///
    /// - Returns: return `true` when current page index is less than the total pages
    func nextPageAvaiable() -> Bool {
        return self.currentPage < self.numberOfPages
    }

    /// Resets all the variable to it's initial state
    func resetSearchResult() {
        self.searchResult = nil
        self.currentPage = 1
        self.currentSearchText = ""
        MovieImageCache.shared.removeAllObjects()
    }
    
    /// Add new fetched result into the movie list array
    ///
    /// - Parameter searchResult: Instance of `MovieSearchResult`
    func addSearchResult(searchResult: MovieSearchResult) {
        self.currentPage = searchResult.pageNumber

        guard let oldResult = self.searchResult?.results else {
            self.searchResult = searchResult
            return
        }
        guard let newResult = searchResult.results else {
            return
        }
        
        self.searchResult?.results = oldResult + newResult
    }
}
