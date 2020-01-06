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
  
  private var movieDetailViewModel: MovieDetailsViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let header = Bundle.main.loadNibNamed("MovieInfoHeader", owner: nil, options: nil)?.first as! UIView
    tableView.tableHeaderView = header
    movieDetailViewModel.generateDetailedInfo()
  }
  
  @IBAction func clickToExit(_ sender: UIButton) {
    dismiss(animated: true)
  }
  
  func configure(movieDetailViewModel: MovieDetailsViewModel) {
    self.movieDetailViewModel = movieDetailViewModel
  }
}

extension MovieInfoViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return movieDetailViewModel.movieInfos.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieInfoCell", for: indexPath) as? MovieInfoCell else {
      fatalError("Can not create cell")
    }
    cell.configure(withMovieInfo: movieDetailViewModel.movieInfos[indexPath.row])
    return cell
  }
}
