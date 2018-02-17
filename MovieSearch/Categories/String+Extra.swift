//
//  String+Extra.swift
//  MovieSearch
//
//  Created by Ganesh on 2/17/18.
//  Copyright © 2018 Ganesh. All rights reserved.
//

import UIKit

extension String {
    
    init(localizedKey: String) {
        self.init(NSLocalizedString(localizedKey, comment: ""))
    }
}
