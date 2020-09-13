//
//  SourceURLBuilding.swift
//  YummlyTV
//
//  Created by Calin Radu Calin on 15/06/2020.
//  Copyright © 2020 Yummly Inc. All rights reserved.
//

import Foundation

protocol SourceURLBuilding {
  var domain: String { get }
  func makeDirectory() -> String
  func makePath() -> String
  func makeHeader() -> URLRequest.Header
  func makeQueryItems() -> [URLQueryItem]?
  func makeURL() -> URL?
  func makeMethod() -> HTTPMethod
  func makeRequestDataModel() -> Encodable?
  func makeHttpBody() -> Data?
}

extension SourceURLBuilding {

  var domain: String { "https://api.github.com" }

  func makeDirectory() -> String { "" }

  func makeURL() -> URL? {
    guard var components = URLComponents(string: domain) else { return nil }
    components.path = makeDirectory() + makePath()
    components.queryItems = makeQueryItems()
    return components.url
  }

  func makeHeader() -> URLRequest.Header { URLRequest.Header() }

  func makeQueryItems() -> [URLQueryItem]? { nil }

  func makeMethod() -> HTTPMethod { .get }

  func makeRequestDataModel() -> Encodable? { nil }

  func makeHttpBody() -> Data? { makeRequestDataModel()?.makeJsonData() }

}

extension Encodable {
    func makeJsonData() -> Data? { try? JSONEncoder().encode(self) }
}
