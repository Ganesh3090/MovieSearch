//
//  MSConstants.swift
//  MovieSearch
//
//  Created by Ganesh on 2/17/18.
//  Copyright © 2018 Ganesh. All rights reserved.
//

import UIKit

struct MSConfiguration {

    // MARK: - Initializer

    /// Prevent initialization
    private init() { }

    // MARK: - Constants

    /// API key to fetch movie list
    static let apiKey = "2696829a81b1b5827d515ff121700838"
    
    /// The base url for fetching the result
    static let baseURL = "http://api.themoviedb.org/3/search/movie?"
    
    /// The image base URL to download the image
    static let imageBaseURL = "http://image.tmdb.org/t/p/"
    
    /// The image size
    static let w185 = "w185"
    
    /// The image size
    static let w500 = "w185"
}
