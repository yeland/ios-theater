//
//  MovieDetailsViewController.swift
//  ios-theater
//
//  Created by Linxiao Wei on 2019/12/31.
//  Copyright © 2019 Linxiao Wei. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
  @IBOutlet weak var posterImage: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var originalTitleAndYear: UILabel!
  @IBOutlet weak var basicInfoLabel: UILabel!
  
  private var movieId = ""
  private let movieDetailsViewModel = MovieDetailsViewModel()
  
  override func viewDidLoad() {
    navigationController?.navigationBar.isHidden = false
    let title = NSLocalizedString("movie", comment: "")
    self.title = title
    fetchData()
  }
  
  func configure(withMovieId movieId: String) {
    self.movieId = movieId
  }
  
  private func fetchData(){
    movieDetailsViewModel.fetchMovieDetails(movieId: movieId) {
      guard let movie = self.movieDetailsViewModel.movie else { return }
      guard let url = URL(string: movie.images.large) else { return }
      self.posterImage.setImage(withURL: url)
      self.posterImage.layer.cornerRadius = 5
      self.titleLabel.text = movie.title
      self.originalTitleAndYear.text = "\(self.movieDetailsViewModel.showedOriginalTitleAndYear)"
      self.setupBasicInfo()
    }
  }
  
  private func setupBasicInfo() {
    let basicInfoString = NSMutableAttributedString(string: self.movieDetailsViewModel.showedBasicInformation)
    let rightAttachment = NSTextAttachment()
    rightAttachment.image = UIImage(systemName: "chevron.right")?.withTintColor(.darkGray)
    rightAttachment.bounds = CGRect(x: 0, y: -1, width: 8, height: 12)
    let rightString = NSAttributedString(attachment: rightAttachment)
    basicInfoString.append(rightString)
    self.basicInfoLabel.attributedText = basicInfoString
  }
}
