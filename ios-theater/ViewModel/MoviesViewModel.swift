//
//  MoviesViewModel.swift
//  ios-theater
//
//  Created by Linxiao Wei on 2019/12/23.
//  Copyright © 2019 Linxiao Wei. All rights reserved.
//

import Foundation

class MoviesViewModel {
  var total = 0
  var hotMovies: [Movie] = []
  
  private let networkClient = NetworkClient()
  
  private let hotMoviesAPI = "https://api.douban.com/v2/movie/in_theaters?apikey=0df993c66c0c636e29ecbb5344252a4a"
  
  func fetchHotMovies(completion: @escaping () -> Void) {
    guard let url = URL(string: hotMoviesAPI) else { return }
    networkClient.request(url: url) { [weak self] data, error in
      if let data = data {
        do {
          let movies = try JSONDecoder().decode(Movies.self, from: data)
          self?.hotMovies = movies.subjects
          self?.total = movies.total
          completion()
        } catch let error {
          print(error.localizedDescription)
        }
      }
      
      if let error = error {
        print(error.localizedDescription)
      }
    }
  }
}
