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
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let header = Bundle.main.loadNibNamed("MovieInfoHeader", owner: nil, options: nil)?.first as! UIView
    tableView.tableHeaderView = header
  }
  
  @IBAction func clickToExit(_ sender: UIButton) {
    dismiss(animated: true)
  }
}
