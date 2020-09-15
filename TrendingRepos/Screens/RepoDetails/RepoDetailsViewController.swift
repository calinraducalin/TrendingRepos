//
//  RepoDetailsViewController.swift
//  TrendingRepos
//
//  Created by Calin Radu Calin on 15/09/2020.
//  Copyright © 2020 Yummly. All rights reserved.
//

import UIKit
import SwiftUI

class RepoDetailsViewController: UIViewController {

  let repository: Repository

  init(repository: Repository) {
    self.repository = repository
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    addChildRepoDetailsView()
    title = repository.name
  }

  private func addChildRepoDetailsView() {
    let controller = UIHostingController(rootView: RepoDetailsView(repository: repository))
    addChild(controller)
    view.addSubview(controller.view)
    controller.didMove(toParent: self)

    controller.view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      controller.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      controller.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      controller.view.topAnchor.constraint(equalTo: view.topAnchor),
      controller.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
}
