//
//  MovieDetailsViewModel.swift
//  ios-theater
//
//  Created by Linxiao Wei on 2019/12/31.
//  Copyright © 2019 Linxiao Wei. All rights reserved.
//

import Foundation

class MovieDetailsViewModel {
  private let networkClient = NetworkClient()
  var movie: Movie?
  
  func fetchMovieDetails(movieId: String, completion: @escaping () -> Void) {
    guard let url = URL(string: "https://api.douban.com/v2/movie/subject/\(movieId)?apikey=0df993c66c0c636e29ecbb5344252a4a") else { return }
    networkClient.request(url: url) { [weak self] data, error in
      if let data = data {
        do {
          self?.movie = try JSONDecoder().decode(Movie.self, from: data)
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
  
  var showedOriginalTitleAndYear: String {
    let originalTitle: String
    guard let movie = movie else { return "" }
    if movie.title != movie.original_title {
      originalTitle = movie.original_title
    } else {
      originalTitle = ""
    }
    return "\(originalTitle)(\(movie.year))"
  }
  
  var showedBasicInformation: String {
    guard let movie = movie, let pubdates = movie.pubdates else { return "" }
    let pubdate = pubdates[pubdates.count - 1]
    return "\(movie.countries?[0] ?? "") / \(movie.genres.joined(separator: " ")) / 上映时间：\(pubdate) / 片长: \(movie.durations?[0] ?? "") "
  }
}
