//
//  MovieDetailsViewModel.swift
//  ios-theater
//
//  Created by Linxiao Wei on 2019/12/31.
//  Copyright © 2019 Linxiao Wei. All rights reserved.
//

import Foundation

@objcMembers class MovieDetailsViewModel: NSObject {
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
    guard
      let countries = movie.countries,
      let durations = movie.durations,
      movie.pubdates.count != 0
    else {
      return ""
    }
    
    let country = countries[0]
    let genres = movie.genres.joined(separator: " ")
    let pubdate = movie.pubdates[movie.pubdates.count - 1]
    let duration = durations[0]
    return "\(country) / \(genres) / 上映时间：\(pubdate) / 片长: \(duration) "
  }
  
  func generateDetailedInfo() {
    guard
      let aka = movie.aka,
      let movieWriters = movie.writers,
      let movieDurations = movie.durations,
      let countries = movie.countries,
      let movieLanguages = movie.languages
    else {
      return
    }
    
    let name = MovieInfo("title", movie.title)
    let originalName = MovieInfo("originalTitle", movie.original_title)
    let otherName = MovieInfo("aka", aka.joined(separator: " / "))
    let directors = MovieInfo("directors", movie.directors.map({ $0.name }).joined(separator: " / "))
    let writers = MovieInfo("writers", movieWriters.map({ $0.name }).joined(separator: " / "))
    let casts = MovieInfo("casts", movie.casts.map({ $0.name }).joined(separator: " / "))
    let pubdates = MovieInfo("pubdates", movie.pubdates.joined(separator: " / "))
    let genres = MovieInfo("genres", movie.genres.joined(separator: " / "))
    let durations = MovieInfo("durations", movieDurations.joined(separator: " / "))
    let country = MovieInfo("region", countries[0])
    let languages = MovieInfo("languages", movieLanguages.joined(separator: " / "))
    
    if movie.title == movie.original_title {
      movieInfos = [name]
    } else {
      movieInfos = [name, originalName]
    }
    movieInfos += [otherName, directors, writers, casts, pubdates, genres, durations, country, languages]
  }
  
  var ratingNumber: Double {
    return movie.rating.average
  }
  
  var percentOfStars: [Double] {
    let ratingDetails = movie.rating.details
    let total = ratingDetails.one + ratingDetails.two + ratingDetails.three + ratingDetails.four + ratingDetails.five
    let ratingNumbers = [ratingDetails.five, ratingDetails.four, ratingDetails.three, ratingDetails.two, ratingDetails.one]
    return ratingNumbers.map({ $0 / total })
  }
  
  var ratingCount: Int {
    return movie.ratings_count ?? 0
  }
  
  var castStaffs: [Person] {
    return movie.directors + movie.casts
  }
  
  func getCommentsHeight() -> CGFloat {
    var totalHeight: CGFloat = 0
    let comments = movie.popular_comments ?? []
    for comment in comments {
      let height = (comment.content).height(constrainedToWidth: UIScreen.main.bounds.width - CGFloat(40), size: 16)
      totalHeight += (height + 100)
    }
    return totalHeight
  }
}

struct MovieInfo {
  var title: String
  var content: String
  
  init(_ key: String, _ content: String) {
    title = NSLocalizedString(key, comment: "")
    self.content = content
  }
}
