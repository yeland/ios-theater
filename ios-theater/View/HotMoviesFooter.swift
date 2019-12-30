//
//  HotMoviesFooter.swift
//  ios-theater
//
//  Created by Linxiao Wei on 2019/12/30.
//  Copyright © 2019 Linxiao Wei. All rights reserved.
//

import UIKit

class HotMoviesFooter: UITableViewHeaderFooterView {
  @IBOutlet weak var indicater: UIActivityIndicatorView!
  @IBOutlet weak var endLabel: UILabel!
  
  func configure() {
    endLabel.isHidden = true
    indicater.isHidden = true
  }
}
