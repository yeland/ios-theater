//
//  Rating.swift
//  ios-theater
//
//  Created by Linxiao Wei on 2019/12/23.
//  Copyright © 2019 Linxiao Wei. All rights reserved.
//

import Foundation

struct Rating: Codable {
  var average: Double
  var details: RatingDetail
}

struct RatingDetail: Codable {
  var one: Double
  var two: Double
  var three: Double
  var four: Double
  var five: Double
  
  private enum CodingKeys: String, CodingKey {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
  }
}
