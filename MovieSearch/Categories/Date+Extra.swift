//
//  Date+Extra.swift
//  MovieSearch
//
//  Created by Ganesh on 2/18/18.
//  Copyright © 2018 Ganesh. All rights reserved.
//

import UIKit

extension Date {

    private static let serverDateFormat = "yyyy-MM-dd"
    
    private static let dateFormat = "dd MMM yyyy"

    static func dateFromString(dateString: String) -> Date? {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = self.serverDateFormat
        
        return dateFormater.date(from: dateString)
    }
    
    static func stringFromDate(date: Date) -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = self.dateFormat
        
        return dateFormater.string(from: date)
    }
}
