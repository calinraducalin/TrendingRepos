//
//  HeaderView.swift
//  TrendingRepos
//
//  Created by Calin Radu Calin on 15/09/2020.
//  Copyright © 2020 Yummly. All rights reserved.
//

import SwiftUI

struct HeaderView: View {

  let repository: Repository

  var body: some View {
    Text(title)
      .font(.body)
  }
  
  private var title: String { repository.details.isEmpty ? "No description available" : repository.details }
}
