//
//  JSONParser.swift
//  YummlyTV
//
//  Created by Calin Radu Calin on 15/06/2020.
//  Copyright © 2020 Yummly Inc. All rights reserved.
//

import Foundation

struct JSONParser<T: Decodable> {
  private let dateDecodingStrategy: JSONDecoder.DateDecodingStrategy
  
  init(dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .iso8601) {
    self.dateDecodingStrategy = dateDecodingStrategy
  }
  
  func parse(from data: Data) -> Result<T, Error> {
    do {
      let decoder = JSONDecoder()
      decoder.dateDecodingStrategy = self.dateDecodingStrategy
      decoder.keyDecodingStrategy = .convertFromSnakeCase
      let object = try decoder.decode(T.self, from: data)
      return .success(object)
    } catch {
      return .failure(error)
    }
  }
}
