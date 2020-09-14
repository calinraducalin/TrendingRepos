//
//  TrendingReposViewController.swift
//  TrendingRepos
//
//  Created by Calin Radu Calin on 13/09/2020.
//  Copyright © 2020 Yummly. All rights reserved.
//

import UIKit


class TrendingReposViewController: UIViewController {

  @IBOutlet private weak var segmentedControl: UISegmentedControl!
  @IBOutlet private weak var collectionView: UICollectionView!

  private let viewModel = TrendingReposViewModel()

  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.delegate = self
    setupCollectionView()
    setupRefreshControl()
    refreshItems()
  }

  //MARK: - Actions
  
  @IBAction private func segmentedControlAction(_ sender: UISegmentedControl) {
    viewModel.segmentedControlAction(selectedIndex: sender.selectedSegmentIndex)
    if viewModel.shouldLoadItems {
      refreshItems()
    }
    collectionView.reloadData()
    collectionView.setContentOffset(.zero, animated: true)
  }

  @objc private func refreshItems() {
    collectionView.refreshControl?.beginRefreshing()
    viewModel.dataSource.loadItems(refresh: true)
  }

  //MARK: - Private

  private func setupCollectionView() {
    collectionView.setCollectionViewLayout(viewModel.makeLayout(), animated: false)
    collectionView.register(UINib(nibName: viewModel.repoCellName, bundle: nil), forCellWithReuseIdentifier: viewModel.repoCellName)
    collectionView.delegate = self
    collectionView.dataSource = self
  }

  private func setupRefreshControl() {
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(refreshItems), for: .valueChanged)
    collectionView.refreshControl = refreshControl
  }

  private func showAlert(title: String?, message: String?) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    present(alertController, animated: true, completion: nil)
  }
}

extension TrendingReposViewController: TrendingReposViewModelDelegate {
  func didLoadItems() {
    collectionView.refreshControl?.endRefreshing()
    collectionView.reloadData()
  }

  func didFailLoadingItems(message: String?) {
    collectionView.refreshControl?.endRefreshing()
    showAlert(title: "Uh oh!", message: message)
  }
}


extension TrendingReposViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.dataSource.numberOfItems
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: viewModel.repoCellName, for: indexPath)
    let item = viewModel.dataSource.item(at: indexPath)
    (cell as? RepoItemCollectionViewCell)?.update(with: item)

    return cell
  }
}

extension TrendingReposViewController: UICollectionViewDelegate {

}

