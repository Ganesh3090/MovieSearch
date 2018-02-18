//
//  RescentSearchTableViewCell.swift
//  MovieSearch
//
//  Created by Ganesh on 2/18/18.
//  Copyright © 2018 Ganesh. All rights reserved.
//

import UIKit

class RescentSearchTableViewCell: MSBaseTableViewCell {

    static let className = "RescentSearchTableViewCell"

    @IBOutlet private weak var searchTitleLabel: MSLabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        self.backgroundColor = UIColor.white
    }
    
    var searchTitle: String? {
        didSet {
            self.searchTitleLabel.text = self.searchTitle
        }
    }
}
