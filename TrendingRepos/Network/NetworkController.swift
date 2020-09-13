//
//  NetworkController.swift
//  YummlyTV
//
//  Created by Calin Radu Calin on 15/06/2020.
//  Copyright © 2020 Yummly Inc. All rights reserved.
//

import Foundation

final class NetworkController {
  typealias Completion = (_ result: Result<Data, Error>) -> Void
  
  private let session: URLSession
  private let responseQueue: DispatchQueue
  
  init(session: URLSession = .shared, responseQueue: DispatchQueue = .main) {
    self.session = session
    self.responseQueue = responseQueue
  }
  
  func executeRequestFor(url: URL, completion: @escaping Completion) {
    let request = URLRequest(url: url)
    executeRequest(urlRequest: request, completion: completion)
  }
  
  func executeRequest(urlRequest: URLRequest, completion: @escaping Completion) {
    let task = session.dataTask(with: urlRequest) { [weak self] (data, response, error) in
      if let error = error {
        completion(.failure(error))
        return
      }
      if response?.isSuccessful == false {
        completion(.failure(ModelError.from(data: data)))
        return
      }
      self?.responseQueue.async {
        if let data = data {
          completion(.success(data))
        } else {
          completion(.failure(ModelError.noServerData))
        }
      }
    }
    task.resume()
  }
  
  func cancelAllRunningTasks() {
    session.getAllTasks { tasks in
      tasks.forEach { $0.cancel() }
    }
  }
}
