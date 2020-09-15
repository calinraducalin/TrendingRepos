//
//  RepoDetailsView.swift
//  TrendingRepos
//
//  Created by Calin Radu Calin on 15/09/2020.
//  Copyright © 2020 Yummly. All rights reserved.
//

import SwiftUI

struct RepoDetailsView: View {

  let repository: Repository

  var body: some View {
    List {
      Section(header: HeaderView(repository: repository),
              footer: FooterView(repository: repository)) {
        ForEach(makeCellModels()) { trail in
          CellView(model: trail)
        }
      }
    }
    .listStyle(GroupedListStyle())
  }

  //MARK: - Private

  private func makeDateText() -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    let dateText = formatter.string(from: repository.createdAt)
    return "Created at \(dateText)"
  }

  private func makeCellModels() -> [CellModel] {[
    CellModel(imageName: "command", text: repository.language),
    CellModel(imageName: "tuningfork", text: "\(repository.stargazersCount) Forks"),
    CellModel(imageName: "star", text: "\(repository.stargazersCount) Stars"),
    CellModel(imageName: "clock", text: makeDateText()),
  ]}
}

struct RepoDetailsView_Previews: PreviewProvider {
  static var previews: some View {
    RepoDetailsView(repository: Repository())
  }
}
