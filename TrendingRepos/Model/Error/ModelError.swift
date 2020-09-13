//
//  ModelError.swift
//  YummlyTV
//
//  Created by Calin Radu Calin on 12/06/2020.
//  Copyright © 2020 Yummly Inc. All rights reserved.
//

import Foundation

struct ModelError: LocalizedError {
  let description: String

  var errorDescription: String? {
    return description
  }

  static let noServerData = ModelError(description: "Internal Server Error")
  static let invalidURL = ModelError(description: "URL is not valid")
}

extension ModelError {
  static func from(data: Data?) -> ModelError {
    return ModelError.noServerData
  }
}
