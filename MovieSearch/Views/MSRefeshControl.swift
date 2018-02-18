//
//  MSRefeshControl.swift
//  MovieSearch
//
//  Created by Ganesh on 2/18/18.
//  Copyright © 2018 Ganesh. All rights reserved.
//

import UIKit

class MSRefeshControl: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.loadFromXib()
        self.configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.loadFromXib()
        self.configureUI()
    }
    
    private func configureUI() {
        self.backgroundColor = UIColor.theme
    }
}
