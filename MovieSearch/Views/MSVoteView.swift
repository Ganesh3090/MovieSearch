//
//  MSVoteView.swift
//  MovieSearch
//
//  Created by Ganesh on 2/17/18.
//  Copyright © 2018 Ganesh. All rights reserved.
//

import UIKit

class MSVoteView: UIView {

    @IBOutlet weak var voteAvarageLabel: MSLabel!
    @IBOutlet weak var voteLabel: MSLabel!
    @IBOutlet weak var voteImageView: UIImageView!
    
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
        self.layer.cornerRadius = 5.0
        self.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        self.widthAnchor.constraint(equalToConstant: 120.0).isActive = true
        self.heightAnchor.constraint(equalToConstant: 66.0).isActive = true
    }
    
    func setVoteCount(count: Int, avarage: Double) {
        self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
       
        if count > 0 {
            self.voteLabel.text =  String(count) + " " + String(localizedKey: "VOTES")
        } else {
            self.voteLabel.text =  String(localizedKey: "NO_VOTES")
        }
        let averageInPercent = Int(avarage * 10)
        self.voteAvarageLabel.text = String(averageInPercent) + "%"
    }
}
