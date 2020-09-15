//
//  CellModel.swift
//  TrendingRepos
//
//  Created by Calin Radu Calin on 15/09/2020.
//  Copyright © 2020 Yummly. All rights reserved.
//

import Foundation

struct CellModel: Identifiable {
  var id: String { text }
  let imageName: String
  let text: String
}
