//
//  Movies.swift
//  ios-theater
//
//  Created by Linxiao Wei on 2019/12/23.
//  Copyright © 2019 Linxiao Wei. All rights reserved.
//

import Foundation

struct Movies: Codable {
  var count: Int
  var start: Int
  var total: Int
  var subjects: [Movie]
}

struct Movie: Codable {
  var rating: Rating
  var title: String
  var original_title: String
  var images: Images
  var id: String
  var year: String
  var genres:[String]
  var casts: [Person]
  var directors: [Person]
  var countries: [String]?
  var pubdates: [String]
  var durations: [String]?
  var aka: [String]?
  var writers: [Person]?
  var languages: [String]?
  let ratings_count: Int?
}

struct Images: Codable {
  var small: String
  var medium: String
  var large: String
}

struct Person: Codable {
  var avatars: Images?
  var name: String
}
