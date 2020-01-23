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
  var ratings_count: Int?
  var summary: String?
  var popular_comments: [Comment]?
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

struct Comment: Codable {
  var rating: RatingInComment
  var author: Author
  var content: String
  var created_at: String
}

struct RatingInComment: Codable {
  var value: Double
}

struct Author: Codable {
  var avatar: String
  var name: String
}
