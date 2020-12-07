//
//  MovieCollectionViewCell.swift
//  Movies
//
//  Created by Omar Huchin on 05/12/20.
//  Copyright © 2020 Omar.Huchin. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var layerView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
    @IBOutlet weak var starImageView: UIImageView!
    public func populate(movie: Movie){
        titleLabel.text = movie.title 
        voteAverageLabel.text = "\(movie.voteAverage ?? 0)"
        backgroundImageView.setImage(fromPath: movie.posterPath)
        dateLabel.text = movie.releaseDate
    }
}
