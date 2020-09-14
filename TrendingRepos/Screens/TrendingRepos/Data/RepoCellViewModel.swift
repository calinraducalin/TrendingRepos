//
//  RepoCellViewModel.swift
//  TrendingRepos
//
//  Created by Calin Radu Calin on 14/09/2020.
//  Copyright © 2020 Yummly. All rights reserved.
//

import Foundation

protocol RepoCellViewModel: AnyObject {
  var title: String? { get }
  var subtitle: String? { get }
  var imageURL: URL? { get }
  var isFavorite: Bool { get }
}
