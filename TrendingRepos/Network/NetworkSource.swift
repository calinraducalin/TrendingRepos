//
//  NetworkSource.swift
//  YummlyTV
//
//  Created by Calin Radu Calin on 15/06/2020.
//  Copyright © 2020 Yummly Inc. All rights reserved.
//

import Foundation

struct NetworkSource<Element: Codable> {
  typealias Object = Element
  typealias Completion = (Result<[Element], Error>) -> Void

  private let urlBuilder: SourceURLBuilding
  private let networkController: NetworkController

  init(urlBuilder: SourceURLBuilding,
       networkController: NetworkController = NetworkController()) {
    self.urlBuilder = urlBuilder
    self.networkController = networkController
  }

  func getResult(completion: @escaping (Result<Element, Error>) -> Void) {
    guard let url = urlBuilder.makeURL() else {
      return completion(.failure(ModelError.invalidURL))
    }
    var request = URLRequest(url: url)
    request.addHeaders(urlBuilder.makeHeader())
    request.method = urlBuilder.makeMethod()
    request.httpBody = urlBuilder.makeHttpBody()
    networkController.executeRequest(urlRequest: request) { result in
      switch result {
      case .success(let data):
        let parser = JSONParser<Element>()
        let result = parser.parse(from: data)
        DispatchQueue.main.async {
          completion(result)
        }
      case .failure(let error):
        DispatchQueue.main.async {
          completion(.failure(error))
        }
      }
    }
  }

  func cancel() {
    networkController.cancelAllRunningTasks()
  }
}

extension URL {

    func appending(_ queryItem: URLQueryItem) -> URL? {

        guard var urlComponents = URLComponents(string: absoluteString) else { return nil }

        var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []
        queryItems.append(queryItem)
        urlComponents.queryItems = queryItems

        return urlComponents.url
    }
}
