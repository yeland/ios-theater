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
  
  func configure(movie: Movie) {
    guard let url = URL(string: movie.images.large) else { return }
    self.postImage.setImage(withURL: url)
    self.nameLabel.text = movie.title
  }
}
