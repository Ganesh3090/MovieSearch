//
//  MovieSearchRequest.swift
//  MovieSearch
//
//  Created by Ganesh on 2/17/18.
//  Copyright © 2018 Ganesh. All rights reserved.
//

import Foundation

struct MovieSearchRequest {
    
    // MARK: - Variables

    /// The key use to search the movie in `URL`
    let searchKey: String
    
    /// The key used in `URL` to fetch page
    let pageNumber: Int
    
    // MARK: - Initializer

    /// Designated initializer for `MovieSearchRequest`
    ///
    /// - Parameters:
    ///   - searchKey: The key use to search the movie in `URL`
    ///   - pageNumber: The key used in `URL` to fetch page
    init(searchKey: String, pageNumber: Int) {
        self.searchKey = searchKey
        self.pageNumber = pageNumber
    }
    
    // MARK: - Methods

    /// Creates the HTTP body using parameter list
    ///
    /// - Returns: Paramterised URL string
    func stringByAppendingAllParameters() -> String {
        var urlString = ""
        
        urlString.append(MovieSearchParameter.apiKey + "=" + MSConfiguration.apiKey)
        urlString.append("&")
        urlString.append(MovieSearchParameter.query + "=" + self.searchKey)
        urlString.append("&")
        urlString.append(MovieSearchParameter.pageNumber + "=" + String(self.pageNumber))
        
        return urlString
    }
}

