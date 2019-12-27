//
//  MovieCollectionCell.swift
//  ios-theater
//
//  Created by Linxiao Wei on 2019/12/24.
//  Copyright © 2019 Linxiao Wei. All rights reserved.
//

import UIKit

class MovieCollectionCell: UICollectionViewCell {
  @IBOutlet weak var postImage: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var ratingLabel: UILabel!
  
  func configure(movie: Movie) {
    guard let url = URL(string: movie.images.large) else { return }
    self.postImage.setImage(withURL: url)
    self.postImage.layer.cornerRadius = 5
    self.nameLabel.text = movie.title
    setupRatingLabel(rating: movie.rating.average)
  }
  
  func setupRatingLabel(rating: Double) {
    let ratingNumber = NSMutableAttributedString(string: " \(rating)")
    let ratingString = ratingLabel.setStars(rating: rating, size: 14)
    ratingString.append(ratingNumber)
    ratingString.addAttribute(.foregroundColor, value: UIColor.systemYellow, range: NSRange(location: 0, length: 5))
    ratingLabel.attributedText = ratingString
  }
}
