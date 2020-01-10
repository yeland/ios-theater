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
  @IBOutlet weak var ratingView: RatingView!
  @IBOutlet weak var introductionLabel: UILabel!
  
  private var movieDetailsViewModel: MovieDetailsViewModel!
  
  override func viewDidLoad() {
    navigationController?.navigationBar.isHidden = false
    let title = NSLocalizedString("movie", comment: "")
    self.title = title

    let movie = self.movieDetailsViewModel.movie
    guard let url = URL(string: movie.images.large) else { return }
    self.posterImage.setImage(withURL: url)
    self.posterImage.layer.cornerRadius = 5
    self.titleLabel.text = movie.title
    self.originalTitleAndYear.text = "\(self.movieDetailsViewModel.showedOriginalTitleAndYear)"
    let tap = UITapGestureRecognizer(target: self, action: #selector(clickToGetMoreInformation))
    basicInfoLabel.isUserInteractionEnabled = true
    basicInfoLabel.addGestureRecognizer(tap)
    
    ratingView.configure(movieDetailsViewModel)
    ratingView.layer.cornerRadius = 10
    fetchData()
  }
  
  func configure(withMovie movie: Movie) {
    movieDetailsViewModel = MovieDetailsViewModel(withMovie: movie)
  }
  
  @objc func clickToGetMoreInformation() {
    let movieInfoViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MovieInfoViewController") as MovieInfoViewController
    movieInfoViewController.configure(movieDetailViewModel: movieDetailsViewModel)
    present(movieInfoViewController, animated: true)
  }
  
  private func fetchData() {
    movieDetailsViewModel.fetchMovieDetails() {
      self.setupBasicInfo()
      self.ratingView.setRatingCount()
      self.setupIntroduction()
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
  
  private func setupIntroduction() {
    let summary = movieDetailsViewModel.movie.summary ?? ""
    let linesArray = summary.getLinesArrayFromLabel(font: introductionLabel.font, rect: introductionLabel.frame)
    var introductionString = NSMutableAttributedString(string: linesArray[0])
    if linesArray.count <= 4 {
      introductionString = NSMutableAttributedString(string: movieDetailsViewModel.movie.summary ?? "")
    } else {
      let fourthLine = generateFourthLine(content: linesArray[3])
      introductionString.append(NSAttributedString(string: linesArray[1]))
      introductionString.append(NSAttributedString(string: linesArray[2]))
      introductionString.append(fourthLine)
    }
    
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineSpacing = 6
    introductionString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: introductionString.length))
    introductionLabel.attributedText = introductionString
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(clickToShowMore))
    introductionLabel.isUserInteractionEnabled = true
    introductionLabel.addGestureRecognizer(tap)
  }
  
  private func generateFourthLine(content: String) -> NSAttributedString {
    let readMore = NSLocalizedString("readMore", comment: "")
    let rect = introductionLabel.frame
    let width = rect.width - readMore.getWidth(font: introductionLabel.font)
    let frame = CGRect(x: 0, y: 0, width: width, height: rect.height)
    let fourthLines = content.getLinesArrayFromLabel(font: introductionLabel.font, rect: frame)
    let fourthLine = NSMutableAttributedString(string: fourthLines[0])
    if fourthLines.count == 1 {
      fourthLine.replaceCharacters(in: NSRange(location: fourthLine.length - 1, length: 1), with: readMore)
    } else {
      fourthLine.append(NSAttributedString(string: readMore))
    }
    fourthLine.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: fourthLine.length - readMore.count, length: readMore.count))
    return fourthLine
  }
  
  @objc private func clickToShowMore() {
    let introductionString = NSMutableAttributedString(string: movieDetailsViewModel.movie.summary ?? "")
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineSpacing = 6
    introductionString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: introductionString.length))
    introductionLabel.attributedText = introductionString
  }
}
