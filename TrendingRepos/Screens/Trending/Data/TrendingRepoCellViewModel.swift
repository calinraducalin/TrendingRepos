//
//  TrendingRepoCellViewModel.swift
//  TrendingRepos
//
//  Created by Calin Radu Calin on 14/09/2020.
//  Copyright © 2020 Yummly. All rights reserved.
//

import Foundation

class TrendingRepoCellViewModel: RepoCellViewModel {
  let repoItem: RepoItem
  let persistanceManager: PersistanceManager

  init(repoItem: RepoItem, persistanceManager: PersistanceManager) {
    self.repoItem = repoItem
    self.persistanceManager = persistanceManager
  }

  var title: String? { repoItem.fullName }
  var subtitle: String? { repoItem.description }
  var imageURL: URL? { repoItem.owner?.avatarUrl }
  var isFavorite: Bool { persistanceManager.isFavorite(item: repoItem) }
}
