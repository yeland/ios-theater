//
//  MovieDetailsViewController.swift
//  ios-theater
//
//  Created by Linxiao Wei on 2019/12/31.
//  Copyright © 2019 Linxiao Wei. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
  private var movieId = ""
  
  override func viewDidLoad() {
    navigationController?.navigationBar.isHidden = false
    self.title = movieId
  }
  
  func configure(withMovieId movieId: String) {
    self.movieId = movieId
  }
}
