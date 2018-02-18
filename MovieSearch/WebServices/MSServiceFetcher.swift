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
    ///   - completion: The movie result. `nil` if there is any error while fetching or parsing the data
    func fetchSearchResult(request: MovieSearchRequest, completion: @escaping (_ result: MovieSearchResult?) -> ()) {
        self.dataTask?.cancel()
        
        let urlString = MSConfiguration.baseURL + request.stringByAppendingAllParameters()
        
        guard let url = URL(string: urlString) else { return }
        
        self.dataTask = defaultSession.dataTask(with: url) { jsonData, response, error in
            
            if let jsonError = error {
                print(jsonError.localizedDescription)
                completion(nil)
                return
            }
            
            guard let data = jsonData else { return }
            
            let result = DataParser.parseMovieSearchJSONData(data: data)
            
            DispatchQueue.main.async {
                completion(result)
            }
        }
        dataTask?.resume()
    }
    
    class func downloadImage(urlString: String, completion: @escaping (_ image: UIImage?) -> Void) {
        if let cachedImage = MovieImageCache.shared.imageForUrl(urlString: urlString) {
            completion(cachedImage)
        } else {
            guard let url = URL(string: urlString) else { return }
            let dataTask = URLSession.shared.dataTask(with: url) { imageData, response, error in
                DispatchQueue.main.async {
                    if error != nil {
                        completion(nil)
                    } else if let data = imageData, let image = UIImage(data: data) {
                        MovieImageCache.shared.cacheImage(image: image, urlString: urlString)
                        completion(image)
                    } else {
                        completion(nil)
                    }
                }
            }
            dataTask.resume()
        }
    }
}
