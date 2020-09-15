//
//  FavoriteReposViewModel.swift
//  TrendingRepos
//
//  Created by Calin Radu Calin on 15/09/2020.
//  Copyright © 2020 Yummly. All rights reserved.
//

import UIKit

class FavoriteReposViewModel: ReposCollectionViewModel {

  let layoutType: LayoutType
  private let persistanceManager = PersistanceManager()
  private var repositories = [Repository]()

  init() {
    layoutType = UIDevice.current.userInterfaceIdiom == .pad ? .grid : .list
    syncRepositories()
  }

  func syncRepositories() {
    repositories = persistanceManager.favoriteRepos
  }

  var numberOfItems: Int { repositories.count }

  func item(at indexPath: IndexPath) -> RepoCellViewModel {
    let repository = repositories[indexPath.item]
    return FavoriteRepoCellViewModel(repository: repository)
  }

  func removeFromFavorites(item: RepoCellViewModel, completion: ((_ removeIndexPath: IndexPath?) -> Void)? = nil) {
    guard let item = item as? FavoriteRepoCellViewModel else { return }
    let removeIndexPath: IndexPath?
    if let index  = repositories.firstIndex(of: item.repository) {
      removeIndexPath = IndexPath(item: index, section: 0)
    } else {
      removeIndexPath = nil
    }
    persistanceManager.removeFromFavorites(itemWithID: item.repository.id)
    syncRepositories()
    completion?(removeIndexPath)
  }
}
