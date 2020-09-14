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

class TrendingReposViewModel {

  enum LayoutType {
    case list, grid

    var numberOfColumns: Int {
      switch self {
      case .list: return 1
      case .grid: return 2
      }
    }
  }

  weak var delegate: TrendingReposViewModelDelegate?
  private let layoutType: LayoutType
  private let trendingAPI = TrendingAPI()
  private(set) var trendingTime: TrendingTime = .lastDay
  private lazy var trendingDataSources: [TrendingReposDataSource] = {
    TrendingTime.allCases.map { TrendingReposDataSource(time: $0, api: trendingAPI, delegate: delegate) }
  }()

  init() {
    layoutType = UIDevice.current.userInterfaceIdiom == .pad ? .grid : .list
  }

  var shouldLoadItems: Bool { dataSource.items.isEmpty }

  var dataSource: TrendingReposDataSource {
    trendingDataSources[trendingTime.rawValue]
  }

  var repoCellName: String { .init(describing: RepoItemCollectionViewCell.self) }

  func makeLayout() -> UICollectionViewLayout {
    let columnsCount = layoutType.numberOfColumns
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                          heightDimension: .estimated(100))
    let subitem = NSCollectionLayoutItem(layoutSize: itemSize)
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize, subitem: subitem, count: columnsCount)
    let section = NSCollectionLayoutSection(group: group)
    section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
    section.interGroupSpacing = 10
    let layout = UICollectionViewCompositionalLayout(section: section)

    return layout
  }

  func segmentedControlAction(selectedIndex: Int) {
    if let time = TrendingTime(rawValue: selectedIndex) {
      trendingTime = time
    }
  }

}

