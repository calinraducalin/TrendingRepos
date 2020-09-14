//
//  TrendingAPI.swift
//  TrendingRepos
//
//  Created by Calin Radu Calin on 13/09/2020.
//  Copyright © 2020 Yummly. All rights reserved.
//

import Foundation

class TrendingAPI {

  private var trendingSource: NetworkSource<TrendingFeed>?

  func getTrendingRepositories(from time: TrendingTime, at page: Int = 1, completion: @escaping (_ result: Result<TrendingFeed, Error>) -> Void) {
    trendingSource = NetworkSource<TrendingFeed>(urlBuilder: TrendingURLBuilding(time: time, page: page))
    trendingSource?.getResult(completion: completion)
  }

}

fileprivate struct TrendingURLBuilding: SourceURLBuilding {
  let time: TrendingTime
  let page: Int

  func makePath() -> String { "/search/repositories" }

  func makeQueryItems() -> [URLQueryItem]? {[
    URLQueryItem(name: "q", value: makeQValue()),
    URLQueryItem(name: "sort", value: "stars"),
    URLQueryItem(name: "order", value: "desc"),
    URLQueryItem(name: "page", value: String(page))
  ]}

  //MARK: - Private

  private func makeFilterDate() -> Date {
    let currentDate = Date()
    let filterComponent = time.makeCalendarComponent()
    let filterDate = Calendar.current.date(byAdding: filterComponent, value: -1, to: currentDate) ?? currentDate
    return filterDate
  }

  private func makeQValue() -> String {
    let date = makeFilterDate()
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    let filterDateText = formatter.string(from: date)
    return "created:>\(filterDateText)"
  }
}
