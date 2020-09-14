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

  init(repoItem: RepoItem) {
    self.repoItem = repoItem
  }

  var title: String? { repoItem.fullName }
  var subtitle: String? { repoItem.description }
  var imageURL: URL? { repoItem.owner?.avatarUrl }
  var isFavorite: Bool { true }

}
