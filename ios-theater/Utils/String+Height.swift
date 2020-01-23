//
//  String+Height.swift
//  ios-theater
//
//  Created by Linxiao Wei on 2020/1/22.
//  Copyright © 2020 Linxiao Wei. All rights reserved.
//

import Foundation

extension String {
  func height(constrainedToWidth width: CGFloat, size: CGFloat) -> CGFloat {
    return NSString(string: self).boundingRect(
      with: CGSize(width: width, height: .greatestFiniteMagnitude),
      options: .usesLineFragmentOrigin,
      attributes: [.font: UIFont.systemFont(ofSize: size)],
      context: nil).size.height
  }
}
