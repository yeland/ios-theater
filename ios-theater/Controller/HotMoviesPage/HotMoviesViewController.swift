//
//  HotMoviesController.swift
//  ios-theater
//
//  Created by Linxiao Wei on 2019/12/27.
//  Copyright © 2019 Linxiao Wei. All rights reserved.
//

import UIKit

class HotMoviesViewController: UITableViewController {
  private var moviesViewModel = MoviesViewModel()
  
  override func viewDidLoad() {
    navigationController?.navigationBar.isHidden = false
    tableView.register(UINib(nibName: "MovieTableCell", bundle: nil), forCellReuseIdentifier: "MovieTableCell")
    tableView.dataSource = self
    tableView.delegate = self
  }
  
  func configure(with moviesViewModel: MoviesViewModel) {
    self.moviesViewModel = moviesViewModel
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return moviesViewModel.hotMovies.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableCell", for: indexPath) as? MovieTableCell else {
      fatalError("Can not create cell")
    }
    cell.configure(with: moviesViewModel.hotMovies[indexPath.row])
    return cell
  }
  
}
