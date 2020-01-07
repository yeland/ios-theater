//
//  RatingStars.swift
//  ios-theater
//
//  Created by Linxiao Wei on 2019/12/25.
//  Copyright © 2019 Linxiao Wei. All rights reserved.
//

import UIKit

@objc extension UILabel {
  func setStars(rating: Double, size: CGFloat) -> NSMutableAttributedString {
    let notEmptyStarsNumber = Int(ceil(rating/2))
    let notEmptyStars = generateNotEmptyStars(number: notEmptyStarsNumber, rating: rating, size: size)
    let emptyStars = generateEmptyStars(number: 5 - notEmptyStarsNumber, size: size)
    let starsString = NSMutableAttributedString(string: "")
    starsString.append(notEmptyStars)
    starsString.append(emptyStars)
    self.attributedText = starsString
    return starsString
  }
  
  func generateNotEmptyStars(number: Int, rating: Double, size: CGFloat) -> NSMutableAttributedString {
    let notEmptyStarsString = NSMutableAttributedString(string: "")
    if number == 0 { return notEmptyStarsString }
    let halfFillStarString = generateString(iconName: "star.lefthalf.fill", size: size)
    let fillStarString = generateString(iconName: "star.fill", size: size)
    for _ in 0..<number-1 {
      notEmptyStarsString.append(fillStarString)
    }
    if Double(number * 2) > rating {
      notEmptyStarsString.append(halfFillStarString)
    } else {
      notEmptyStarsString.append(fillStarString)
    }
    return notEmptyStarsString
  }
  
  func generateEmptyStars(number: Int, size: CGFloat) -> NSMutableAttributedString {
    let emptyStarsString = NSMutableAttributedString(string: "")
    let starString = generateString(iconName: "star", size: size)
    for _ in 0..<number {
      emptyStarsString.append(starString)
    }
    return emptyStarsString
  }
  
  func generateString(iconName: String, size: CGFloat) -> NSAttributedString {
    let attachment = NSTextAttachment()
    attachment.image = UIImage(systemName: iconName)?.withRenderingMode(.alwaysTemplate)
    attachment.bounds = CGRect(x: 0, y: -2, width: size, height: size)
    return NSAttributedString(attachment: attachment)
  }
}
