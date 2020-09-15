//
//  FavoriteReposViewContoller.swift
//  TrendingRepos
//
//  Created by Calin Radu Calin on 15/09/2020.
//  Copyright © 2020 Yummly. All rights reserved.
//

import UIKit

class FavoriteReposViewContoller: UIViewController {

  @IBOutlet private weak var collectionView: UICollectionView!
  private let viewModel = FavoriteReposViewModel()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupCollectionView()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    viewModel.syncRepositories()
    collectionView.reloadData()
  }


  //MARK: - Private

  private func setupCollectionView() {
    collectionView.setCollectionViewLayout(viewModel.makeLayout(), animated: false)
    collectionView.register(UINib(nibName: viewModel.repoCellName, bundle: nil), forCellWithReuseIdentifier: viewModel.repoCellName)
    collectionView.delegate = self
    collectionView.dataSource = self
  }

  private func removeFromFavorite(item: RepoCellViewModel) {
    viewModel.removeFromFavorites(item: item, completion: { [weak self] removeIndexPath in
      if let indexPath = removeIndexPath {
        self?.collectionView.deleteItems(at: [indexPath])
      } else {
        self?.collectionView.reloadData()
      }
    })
  }
}

extension FavoriteReposViewContoller:  UICollectionViewDataSource {

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { viewModel.numberOfItems }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: viewModel.repoCellName, for: indexPath)
    let item = viewModel.item(at: indexPath)
    (cell as? RepoItemCollectionViewCell)?.update(with: item)
    (cell as? RepoItemCollectionViewCell)?.delegate = self

    return cell
  }

}

extension FavoriteReposViewContoller: UICollectionViewDelegate {

}

extension FavoriteReposViewContoller:  RepoItemCollectionViewCellDelegate {
  func didTapFavoriteButton(item: RepoCellViewModel) {
    let removeAction = UIAlertAction(title: "Remove", style: .destructive) { [weak self] _ in
      self?.removeFromFavorite(item: item)
    }
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
    let title = "Remove from Favorites"
    let message = "Are you sure you want to remove \(item.title ?? "") from Favorites?"
    let alertController = makeAlertController(
      style: .actionSheet, title: title, message: message, actions: [removeAction, cancelAction]
    )
    present(alertController, animated: true)
  }
}

