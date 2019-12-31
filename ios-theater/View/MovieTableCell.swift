//
//  MovieTableCell.swift
//  ios-theater
//
//  Created by Linxiao Wei on 2019/12/27.
//  Copyright © 2019 Linxiao Wei. All rights reserved.
//

import UIKit

class MovieTableCell: UITableViewCell {
  @IBOutlet weak var posterImage: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var infoLabel: UILabel!
  @IBOutlet weak var starsLabel: UILabel!
  @IBOutlet weak var ratingLabel: UILabel!
  
  func configure(with movie: Movie) {
    guard let url = URL(string: movie.images.large) else { return }
    posterImage.setImage(withURL: url)
    posterImage.layer.cornerRadius = 3
    titleLabel.text = movie.title
    infoLabel.text = "\(movie.year) / \(movie.genres.joined(separator: " ")) / \(movie.directors.map({ $0.name }).joined(separator: " ")) / \(movie.casts.map({ $0.name }).joined(separator: " "))"
    let ratingString = starsLabel.setStars(rating: movie.rating.average, size: 15)
    ratingString.addAttribute(.foregroundColor, value: UIColor.systemYellow, range: NSRange(location: 0, length: 5))
    starsLabel.attributedText = ratingString
    ratingLabel.text = "\(movie.rating.average)"
  }
}
