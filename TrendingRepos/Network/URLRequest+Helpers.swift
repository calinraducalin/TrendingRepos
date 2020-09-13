//
//  URLRequest+Helpers.swift
//  YummlyTV
//
//  Created by Calin Radu Calin on 15/06/2020.
//  Copyright © 2020 Yummly Inc. All rights reserved.
//

import Foundation

extension URLRequest {
  typealias Header = [String: String]
  
  mutating func addHeaders(_ headers: Header) {
    for (key, value) in headers {
      addValue(value, forHTTPHeaderField: key)
    }
  }

  var method: HTTPMethod? {
    get { httpMethod.flatMap(HTTPMethod.init) }
    set { httpMethod = newValue?.rawValue }
  }
}

enum HTTPMethod: String {
  case delete = "DELETE"
  case get = "GET"
  case patch = "PATCH"
  case post = "POST"
  case put = "PUT"
}

