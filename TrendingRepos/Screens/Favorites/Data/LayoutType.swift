//
//  LayoutType.swift
//  TrendingRepos
//
//  Created by Calin Radu Calin on 15/09/2020.
//  Copyright © 2020 Yummly. All rights reserved.
//

import Foundation

enum LayoutType {
  case list, grid

  var numberOfColumns: Int {
    switch self {
    case .list: return 1
    case .grid: return 2
    }
  }
}
