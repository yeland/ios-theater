//
//  CastCell.swift
//  ios-theater
//
//  Created by Linxiao Wei on 2020/1/14.
//  Copyright © 2020 Linxiao Wei. All rights reserved.
//

import UIKit

class CastCell: UICollectionViewCell {
  @IBOutlet weak var avatarImage: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  
  func configure(withStaff staff: Person) {
    guard let url = URL(string: staff.avatars?.large ?? "") else { return }
    avatarImage.setImage(withURL: url)
    avatarImage.layer.cornerRadius = 5
    nameLabel.text = staff.name
  }
}
