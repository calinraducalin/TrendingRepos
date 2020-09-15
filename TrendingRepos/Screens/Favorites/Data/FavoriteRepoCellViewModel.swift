//
//  FavoriteRepoCellViewModel.swift
//  TrendingRepos
//
//  Created by Calin Radu Calin on 15/09/2020.
//  Copyright © 2020 Yummly. All rights reserved.
//

import Foundation

class FavoriteRepoCellViewModel: RepoCellViewModel {
  let repository: Repository

  init(repository: Repository) {
    self.repository = repository
  }

  var title: String? { repository.fullName }

  var subtitle: String? { repository.details }

  var imageURL: URL? { URL(string: repository.imageURLString) }

  var isFavorite: Bool = true
}
