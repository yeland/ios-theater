//
//  NetworkClient.swift
//  ios-theater
//
//  Created by Linxiao Wei on 2019/12/23.
//  Copyright © 2019 Linxiao Wei. All rights reserved.
//

import Foundation
import Alamofire

struct NetworkClient {
  func request(url: URL, completion: @escaping (Data?, Error?) -> Void) {
    Alamofire.request(url).validate().responseData { dataResponse in
      switch dataResponse.result {
      case let .success(data):
        completion(data, nil)
      case let .failure(error):
        completion(nil, error)
      }
    }
  }
}
