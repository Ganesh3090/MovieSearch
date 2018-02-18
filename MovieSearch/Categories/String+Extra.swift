//
//  String+Extra.swift
//  MovieSearch
//
//  Created by Ganesh on 2/17/18.
//  Copyright © 2018 Ganesh. All rights reserved.
//

import UIKit

extension String {
    
    /// Create string from localized strings
    ///
    /// - Parameter localizedKey: The key mentioned in localized file
    init(localizedKey: String) {
        self.init(NSLocalizedString(localizedKey, comment: ""))
    }
}
