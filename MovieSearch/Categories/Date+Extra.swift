//
//  Date+Extra.swift
//  MovieSearch
//
//  Created by Ganesh on 2/18/18.
//  Copyright © 2018 Ganesh. All rights reserved.
//

import UIKit

extension Date {

    // MARK: - Constants
    
    private static let serverDateFormat = "yyyy-MM-dd"
    
    private static let dateFormat = "dd MMM yyyy"

    // MARK: - Methods
    
    /// Convert date string into `Date`
    ///
    /// - Parameter dateString: The date string
    /// - Returns: `Date` if given string in valid format
    static func dateFromString(dateString: String) -> Date? {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = self.serverDateFormat
        
        return dateFormater.date(from: dateString)
    }
    
    /// Convert `Date` object into date string
    ///
    /// - Parameter date: The `Date` object
    /// - Returns: Returns `String` value of `Date`
    static func stringFromDate(date: Date) -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = self.dateFormat
        
        return dateFormater.string(from: date)
    }
}
