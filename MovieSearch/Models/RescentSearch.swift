//
//  RescentSearch.swift
//  MovieSearch
//
//  Created by Ganesh on 2/18/18.
//  Copyright © 2018 Ganesh. All rights reserved.
//

import Foundation

class RescentSearch {
    
    static private let totalCapacity = 10

    static private let rescentSearchKey = "rescentResultKey"
    
    static var userDefault = UserDefaults.standard
    
    class func allRescentSearches() -> [String]? {
        return userDefault.object(forKey: self.rescentSearchKey) as? [String]
    }
    
    class func saveResult(result: String) {
        var newResult: [String]
        if var previousResult = self.allRescentSearches() {
            if (previousResult.count == self.totalCapacity) {
                previousResult.removeLast()
            }
            previousResult.insert(result, at: 0)
            newResult = previousResult
        } else {
            newResult = [result]
        }
        
        self.userDefault.set(newResult, forKey: self.rescentSearchKey)
        self.userDefault.synchronize()
    }
}
