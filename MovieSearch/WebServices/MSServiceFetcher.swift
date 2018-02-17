//
//  MSServiceFetcher.swift
//  MovieSearch
//
//  Created by Ganesh on 2/17/18.
//  Copyright © 2018 Ganesh. All rights reserved.
//

import UIKit

struct MovieSearchParameter {
    
    // MARK: - Initializer

    /// Prevent initialization
    private init() { }
    
    // MARK: - Constants

    static let apiKey = "api_key"
    static let query = "query"
    static let pageNumber = "page"
}

class MSServiceFetcher: NSObject {
    
    var defaultSession = URLSession(configuration: .default)

    private var dataTask: URLSessionDataTask?
    
    /// Fetch the data from server using given base url and api key from `MSConfiguration`
    ///
    /// - Parameters:
    ///   - request: The request parameters
    ///   - session: Instance of `URLSession`. Used for unit tests cases only
    ///   - completion: The movie result. `nil` if there is any error while fetching or parsing the data
    func fetchSearchResult(request: MovieSearchRequest, completion: @escaping (_ movieList: [MovieDetails]?) -> ()) {
        self.dataTask?.cancel()
        
        let urlString = MSConfiguration.baseURl + request.stringByAppendingAllParameters()
        
        guard let url = URL(string: urlString) else { return }
        
        self.dataTask = defaultSession.dataTask(with: url) { jsonData, response, error in
            
            if let jsonError = error {
                print(jsonError.localizedDescription)
                completion(nil)
                return
            }
            
            guard let data = jsonData else { return }
            
            let movieList = DataParser.parseMovieSearchJSONData(data: data)
            
            DispatchQueue.main.async {
                completion(movieList)
            }
        }
        dataTask?.resume()
    }
}
