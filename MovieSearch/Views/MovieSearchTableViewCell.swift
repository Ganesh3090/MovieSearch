//
//  MovieSearchTableViewCell.swift
//  MovieSearch
//
//  Created by Ganesh on 2/17/18.
//  Copyright © 2018 Ganesh. All rights reserved.
//

import UIKit

class MovieSearchTableViewCell: MSBaseTableViewCell {

    static let className = "MovieSearchTableViewCell"
    
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var adultLabel: MSLabel!
    @IBOutlet private weak var movieOverviewLabel: MSLabel!
    @IBOutlet private weak var releaseDateLabel: MSLabel!
    @IBOutlet private weak var nameLabel: MSLabel!
    @IBOutlet private weak var moviePosterImageView: UIImageView!
    @IBOutlet private weak var voteView: MSVoteView!
    @IBOutlet private weak var containerView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()

        self.containerView.layer.cornerRadius = 8.0
        self.containerView.clipsToBounds = true
        
        self.adultLabel.layer.cornerRadius = self.adultLabel.frame.width/2.0
        self.adultLabel.layer.borderColor = UIColor.white.cgColor
        self.adultLabel.layer.borderWidth = 1.0
        self.adultLabel.clipsToBounds = true
        self.moviePosterImageView.backgroundColor = UIColor.theme
    }
    
    func setMoiveDetails(details: Movie) {
        self.nameLabel.text = details.title
        self.releaseDateLabel.text = "Release on 12/02/2018"
        self.movieOverviewLabel.text = details.overview
        
        self.voteView.setVoteCount(count: details.voteCount, avarage: details.voteAverage)
        self.adultLabel.isHidden = !details.adult
        
        self.activityIndicator.stopAnimating()
        if let backdropPath = details.backdropPath {
            let imageURLString = MSConfiguration.imageBaseURL + backdropPath
            self.moviePosterImageView.contentMode = .scaleToFill
            if let cachedImage = MovieImageCache.shared.imageForUrl(urlString: imageURLString) {
                self.moviePosterImageView.image = cachedImage
            } else {
                self.activityIndicator.startAnimating()
                self.moviePosterImageView.image = nil
                MSServiceFetcher.downloadImage(urlString: imageURLString) { (_) in
                    
                }
            }
        } else {
            self.moviePosterImageView.contentMode = .center
            self.moviePosterImageView.image = UIImage(named: "placeholder")
        }
    }
}
