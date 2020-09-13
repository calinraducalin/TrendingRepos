//
//  Header.swift
//  YummlyTV
//
//  Created by Calin Radu Calin on 15/06/2020.
//  Copyright © 2020 Yummly Inc. All rights reserved.
//

import Foundation

enum HeaderField: String {
  case authType = "X-Yummly-Auth-Type", authorization = "Authorization", contentType = "Content-Type"
}

enum HeaderValue {
  
  static var yummly: String { "yummly" }
  
  static func authorization(token: CustomStringConvertible) -> String {
    return "Bearer \(token)"
  }

  static var appURLEncoded: String { "application/x-www-form-urlencoded" }

  static var appJSON: String { "application/json" }
}
