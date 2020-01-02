//
//  DetailedInformation.swift
//  ios-theater
//
//  Created by Linxiao Wei on 2020/1/2.
//  Copyright © 2020 Linxiao Wei. All rights reserved.
//

import UIKit

class MovieInfoViewController: UIViewController {
  @IBOutlet weak var exitButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func clickToExit(_ sender: UIButton) {
    dismiss(animated: true)
  }
}
