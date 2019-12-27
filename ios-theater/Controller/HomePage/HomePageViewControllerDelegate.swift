//
//  HomePageViewControllerDelegate.swift
//  ios-theater
//
//  Created by Linxiao Wei on 2019/12/27.
//  Copyright © 2019 Linxiao Wei. All rights reserved.
//

import UIKit

protocol HomePageViewControllerDelegate: class {
  func setCurrentPage()
  func addTimer()
  func removeTimer()
}
