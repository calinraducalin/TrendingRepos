//
//  CellView.swift
//  TrendingRepos
//
//  Created by Calin Radu Calin on 15/09/2020.
//  Copyright © 2020 Yummly. All rights reserved.
//

import SwiftUI

struct CellView: View {
  let model: CellModel

  var body: some View {
    HStack {
      Image(systemName: model.imageName)
        .frame(width: 50, height: 30, alignment: .leading)
      Text(model.text)
        .foregroundColor(.primary)
        .font(.subheadline)
    }
  }
}
