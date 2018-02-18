//
//  MovieSearchManager.swift
//  MovieSearch
//
//  Created by Ganesh on 2/18/18.
//  Copyright © 2018 Ganesh. All rights reserved.
//

import UIKit

class MovieSearchManager {

    static let shared = MovieSearchManager()
    
    var movieResult: [Movie] {
        return self.searchResult?.results ?? []
    }
    
    var rescentSearches: [String] = []
    
    var currentPage = 1
    
    var currentSearchText = ""

    var numberOfPages: Int {
        return self.searchResult?.numberOfPages ?? 1
    }
    
    var searchResult: MovieSearchResult?
    
    private init() { }
    
    func nextPageAvaiable() -> Bool {
        return self.currentPage < self.numberOfPages
    }
    
    func resetSearchResult() {
        self.searchResult = nil
        self.currentPage = 1
        self.currentSearchText = ""
    }
    
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
