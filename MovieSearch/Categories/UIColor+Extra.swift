//
//  UIColor+Extra.swift
//  MovieSearch
//
//  Created by Ganesh on 2/17/18.
//  Copyright © 2018 Ganesh. All rights reserved.
//

import UIKit

extension UIColor {
    
    static let border = UIColor(actualRed: 242, actualGreen: 242, actualBlue: 242)
    
    static let background = UIColor(actualRed: 242, actualGreen: 242, actualBlue: 242)
    
    static let Theme = UIColor.green

    static let headerText = UIColor.black

    static let subHeaderText = UIColor.black
    
    static let bodyText = UIColor.lightGray
}

extension UIColor {

    static let maxColorLength: CGFloat = 255.0

    convenience init(actualRed: Int, actualGreen: Int, actualBlue: Int) {
        let selfType = type(of: self)
        self.init(red: CGFloat(actualRed)/selfType.maxColorLength,
                  green: CGFloat(actualGreen)/selfType.maxColorLength,
                  blue: CGFloat(actualBlue)/selfType.maxColorLength,
                  alpha: 1.0)
    }
}
