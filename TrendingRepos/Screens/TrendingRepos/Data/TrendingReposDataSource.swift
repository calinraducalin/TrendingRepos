//
//  TrendingReposDataSource.swift
//  TrendingRepos
//
//  Created by Calin Radu Calin on 14/09/2020.
//  Copyright © 2020 Yummly. All rights reserved.
//

import Foundation

class TrendingReposDataSource {

  let trendingAPI: TrendingAPI
  let trendingTime: TrendingTime
  var items: [RepoCellViewModel] = []
  var page: Int = 1
  var hasMore: Bool = true
  private weak var delegate: TrendingReposViewModelDelegate?

  init(time: TrendingTime, api: TrendingAPI, delegate: TrendingReposViewModelDelegate?) {
    self.delegate = delegate
    self.trendingTime = time
    self.trendingAPI = api
  }

  var numberOfItems: Int { items.count }

  func item(at indexPath: IndexPath) -> RepoCellViewModel { items[indexPath.item] }

  func loadItems(refresh: Bool) {
    if refresh {
      page = 1
    }

    trendingAPI.getTrendingRepositories(from: trendingTime, at: page) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let feed):
        if refresh {
          self.items.removeAll()
        }
        let feedItem = feed.items ?? []
        let newItems = feedItem.map { TrendingRepoCellViewModel(repoItem: $0) }
        self.items.append(contentsOf: newItems)
        self.delegate?.didLoadItems()
      case .failure(let error):
        self.delegate?.didFailLoadingItems(message: error.localizedDescription)
      }
    }
  }

}
