//
//  FooterView.swift
//  TrendingRepos
//
//  Created by Calin Radu Calin on 15/09/2020.
//  Copyright © 2020 Yummly. All rights reserved.
//

import SwiftUI

struct FooterView: View {
  let repository: Repository

  var body: some View {
    HStack(alignment: .center) {
      Button(action: {
        if let url = URL(string: self.repository.cloneURLString) {
          UIApplication.shared.open(url)
        }
      }) {
        Text("Open in GitHub")
          .font(.headline)
      }
    }
  }
}
