//
//  UIImageView+Networking.swift
//  ios-theater
//
//  Created by Linxiao Wei on 2019/12/24.
//  Copyright © 2019 Linxiao Wei. All rights reserved.
//

import Foundation
import AlamofireImage

extension UIImageView {
  func setImage(withURL url: URL) {
    self.af_setImage(withURL: url)
  }
}
