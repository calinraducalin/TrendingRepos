//
//  TrendingReposViewModel.swift
//  TrendingRepos
//
//  Created by Calin Radu Calin on 14/09/2020.
//  Copyright © 2020 Yummly. All rights reserved.
//

import UIKit

protocol TrendingReposViewModelDelegate: AnyObject {
  func didLoadItems()
  func didFailLoadingItems(message: String?)
}

class TrendingReposViewModel: ReposCollectionViewModel {

  weak var delegate: TrendingReposViewModelDelegate?
  let layoutType: LayoutType
  private let trendingAPI = TrendingAPI()
  private let persistanceManager = PersistanceManager()
  private(set) var trendingTime: TrendingTime = .lastDay
  private lazy var trendingDataSources: [TrendingReposDataSource] = {
    TrendingTime.allCases.map { TrendingReposDataSource(time: $0, api: trendingAPI, persistanceManager: persistanceManager, delegate: delegate) }
  }()

  init() {
    layoutType = UIDevice.current.userInterfaceIdiom == .pad ? .grid : .list
  }

  var shouldDisplayLoadMoreActivity: Bool { dataSource.hasMore && !dataSource.isLoading }

  var footerID: String { String(describing: UICollectionReusableView.self) }

  var shouldLoadItems: Bool { dataSource.items.isEmpty }

  var numberOfSegments: Int { TrendingTime.allCases.count }

  func title(for segmentIndex: Int) -> String? {
    let time = TrendingTime(rawValue: segmentIndex)
    return time?.makeTitle()
  }

  var dataSource: TrendingReposDataSource {
    trendingDataSources[trendingTime.rawValue]
  }

  func segmentedControlAction(selectedIndex: Int) {
    if let time = TrendingTime(rawValue: selectedIndex) {
      trendingTime = time
    }
  }

  func favoriteButtonAction(item: RepoCellViewModel) {
    guard let item = item as? TrendingRepoCellViewModel else { return }
    if item.isFavorite {
      persistanceManager.removeFromFavorites(itemWithID: item.repoItem.id)
    } else {
      persistanceManager.addToFavorites(item: item.repoItem)
    }
  }
}

