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
  private var loadingData = false
  private var hotMoviesFooter = HotMoviesFooter()
  
  override func viewDidLoad() {
    navigationController?.navigationBar.isHidden = false
    self.title = "热门电影"
    tableView.register(UINib(nibName: "MovieTableCell", bundle: nil), forCellReuseIdentifier: "MovieTableCell")
    tableView.dataSource = self
    tableView.delegate = self
    fetchData()
    hotMoviesFooter = Bundle.main.loadNibNamed("HotMoviesFooter", owner: nil, options: nil)?.first as! HotMoviesFooter
    tableView.tableFooterView = hotMoviesFooter
    hotMoviesFooter.configure()
  }
  
  private func fetchData() {
    moviesViewModel.fetchHotMovies(start: 0, count: 20) {
      self.tableView.reloadData()
    }
  }
  
  override func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let offsetY = scrollView.contentOffset.y
    let distance = scrollView.contentSize.height - scrollView.frame.size.height
    
    if offsetY > distance && !loadingData && offsetY > 0 && !moviesViewModel.allHotMoviesLoaded {
      loadingData = true
      moviesViewModel.fetchHotMovies(start: moviesViewModel.hotMovies.count, count: 20) {
        self.tableView.reloadData()
      }
    }
    if offsetY < distance {
      loadingData = false
    }
  }
}

extension HotMoviesViewController {
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
  
  override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if moviesViewModel.allHotMoviesLoaded {
      hotMoviesFooter.indicater.isHidden = true
      hotMoviesFooter.endLabel.isHidden = false
    } else {
      hotMoviesFooter.indicater.isHidden = false
      hotMoviesFooter.endLabel.isHidden = true
    }
  }
}
