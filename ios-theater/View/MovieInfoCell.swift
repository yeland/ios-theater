//
//  MovieInfoCell.swift
//  ios-theater
//
//  Created by Linxiao Wei on 2020/1/2.
//  Copyright © 2020 Linxiao Wei. All rights reserved.
//

import UIKit

class MovieInfoCell: UITableViewCell {
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var contentLabel: UILabel!
  
  func configure(withMovieInfo movieInfo: MovieInfo) {
    titleLabel.text = "\(movieInfo.title)："
    contentLabel.text = "\(movieInfo.content)"
  }
}
