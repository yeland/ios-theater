//
//  CommentCell.swift
//  ios-theater
//
//  Created by Linxiao Wei on 2020/1/22.
//  Copyright © 2020 Linxiao Wei. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {
  @IBOutlet weak var avatarImage: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var rateLabel: UILabel!
  @IBOutlet weak var timeLabel: UILabel!
  @IBOutlet weak var contentLabel: UILabel!
  
  func configure(withComment comment: Comment) {
    guard let url = URL(string: comment.author.avatar) else { return }
    avatarImage.setImage(withURL: url)
    avatarImage.layer.cornerRadius = 25
    nameLabel.text = comment.author.name
    let ratingString = rateLabel.setStars(rating: comment.rating.value, size: 15)
    ratingString.addAttribute(.foregroundColor, value: UIColor.systemYellow, range: NSRange(location: 0, length: 5))
    rateLabel.attributedText = ratingString
    timeLabel.text = comment.created_at
    contentLabel.text = comment.content
  }
}
