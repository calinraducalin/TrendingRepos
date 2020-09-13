//
//  URLResponse+Helpers.swift
//  YummlyTV
//
//  Created by Calin Radu Calin on 15/06/2020.
//  Copyright © 2020 Yummly Inc. All rights reserved.
//

import Foundation

extension URLResponse {

  var isSuccessful: Bool {
    guard let httpResponse = self as? HTTPURLResponse else { return false }
    return httpResponse.statusCode == 200
  }
}
