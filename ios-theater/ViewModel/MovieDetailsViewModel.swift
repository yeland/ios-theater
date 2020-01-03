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
  var movie: Movie
  var movieInfos = [MovieInfo]()
  
  init(withMovie movie: Movie) {
    self.movie = movie
  }
  
  func fetchMovieDetails(completion: @escaping () -> Void) {
    guard let url = URL(string: "https://api.douban.com/v2/movie/subject/\(movie.id)?apikey=0df993c66c0c636e29ecbb5344252a4a") else { return }
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
    if movie.title != movie.original_title {
      originalTitle = movie.original_title
    } else {
      originalTitle = ""
    }
    return "\(originalTitle)(\(movie.year))"
  }
  
  var showedBasicInformation: String {
    guard let countries = movie.countries, let durations = movie.durations else { return "" }
    let country = countries[0]
    let genres = movie.genres.joined(separator: " ")
    let pubdate = movie.pubdates[movie.pubdates.count - 1]
    let duration = durations[0]
    return "\(country) / \(genres) / 上映时间：\(pubdate) / 片长: \(duration) "
  }
  
  func generateDetailedInfo() {
    guard let aka = movie.aka, let movieWriters = movie.writers, let movieDurations = movie.durations, let countries = movie.countries, let movieLanguages = movie.languages else { return }
    let name = MovieInfo(title: "名称", content: movie.title)
    let originalName = MovieInfo(title: "原名", content: movie.original_title)
    let otherName = MovieInfo(title: "又名", content: aka.joined(separator: " / "))
    let directors = MovieInfo(title: "导演", content: movie.directors.map({ $0.name }).joined(separator: " / "))
    let writers = MovieInfo(title: "编剧", content: movieWriters.map({ $0.name }).joined(separator: " / "))
    let casts = MovieInfo(title: "主演", content: movie.casts.map({ $0.name }).joined(separator: " / "))
    let pubdates = MovieInfo(title: "上映", content: movie.pubdates.joined(separator: " / "))
    let genres = MovieInfo(title: "类型", content: movie.genres.joined(separator: " / "))
    let durations = MovieInfo(title: "片长", content: movieDurations.joined(separator: " / "))
    let country = MovieInfo(title: "地区", content: countries[0])
    let languages = MovieInfo(title: "语言", content: movieLanguages.joined(separator: " / "))
    if movie.title == movie.original_title {
      movieInfos = [name]
    } else {
      movieInfos = [name, originalName]
    }
    movieInfos += [otherName, directors, writers, casts, pubdates, genres, durations, country, languages]
  }
}

struct MovieInfo {
  var title: String
  var content: String
}
