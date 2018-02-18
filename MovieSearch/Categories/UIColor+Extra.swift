//
//  UIColor+Extra.swift
//  MovieSearch
//
//  Created by Ganesh on 2/17/18.
//  Copyright © 2018 Ganesh. All rights reserved.
//

import UIKit

extension UIColor {
    
    /// The background color used in for views
    static let background = UIColor(actualRed: 242, actualGreen: 242, actualBlue: 242)
    
    /// The app theme color
    static let theme = UIColor(actualRed: 74, actualGreen: 212, actualBlue: 137)
}

extension UIColor {
    
    // MARK: - Constants
    
    /// The max color value
    static let maxColorLength: CGFloat = 255.0

    /// Create `UIColor` from the RGB values
    ///
    /// - Parameters:
    ///   - actualRed: The actual red value
    ///   - actualGreen: The actual green value
    ///   - actualBlue: The actual blue value
    convenience init(actualRed: Int, actualGreen: Int, actualBlue: Int) {
        let selfType = type(of: self)
        self.init(red: CGFloat(actualRed)/selfType.maxColorLength,
                  green: CGFloat(actualGreen)/selfType.maxColorLength,
                  blue: CGFloat(actualBlue)/selfType.maxColorLength,
                  alpha: 1.0)
    }
}
