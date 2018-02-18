//
//  MovieSearchResult.swift
//  MovieSearch
//
//  Created by Ganesh on 2/18/18.
//  Copyright © 2018 Ganesh. All rights reserved.
//

import UIKit

struct MovieSearchResult {

    /// Current page of the result
    var pageNumber = 0
    
    /// Total number pages available in the search
    var numberOfPages = 0

    /// The total result for a search
    var totalResult = 0
    
    /// The result of the current page
    var results: [Movie]?
}
