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
    setupSegmentedControl()
    refreshItems()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    collectionView.reloadData()
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
    collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: viewModel.footerID)
    collectionView.register(UINib(nibName: viewModel.repoCellName, bundle: nil), forCellWithReuseIdentifier: viewModel.repoCellName)
    collectionView.delegate = self
    collectionView.dataSource = self
  }

  private func setupRefreshControl() {
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(refreshItems), for: .valueChanged)
    collectionView.refreshControl = refreshControl
  }

  func setupSegmentedControl() {
    for index in 0 ..< viewModel.numberOfSegments {
      segmentedControl.setTitle(viewModel.title(for: index), forSegmentAt: index)
    }
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
    (cell as? RepoItemCollectionViewCell)?.delegate = self

    return cell
  }

  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: viewModel.footerID, for: indexPath)
    if viewModel.shouldDisplayLoadMoreActivity {
      addActivityIndicatorIfNeeded(to: view)
      viewModel.dataSource.loadItems()
    } else {
      removeActivityIndicator(from: view)
    }
    return view
  }

  //MARK: - Private

  private func activityIndicator(in view: UIView) -> UIActivityIndicatorView? {
    return view.subviews.compactMap{ $0 as? UIActivityIndicatorView }.first
  }

  private func addActivityIndicatorIfNeeded(to view: UIView) {
    guard activityIndicator(in: view) == nil else { return }

    let activityIndicator = UIActivityIndicatorView(style: .large)
    activityIndicator.center = CGPoint(x: view.center.x, y: 15)
    activityIndicator.hidesWhenStopped = true
    activityIndicator.startAnimating()
    view.addSubview(activityIndicator)
  }

  private func removeActivityIndicator(from view: UIView) {
    let activityView = activityIndicator(in: view)
    activityView?.removeFromSuperview()
  }
}

extension TrendingReposViewController: UICollectionViewDelegate {

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let item = viewModel.dataSource.item(at: indexPath) as? TrendingRepoCellViewModel else { return }
    let repository = Repository()
    repository.update(with: item.repoItem)
    let repoDetailsController = RepoDetailsViewController(repository: repository)
    navigationController?.pushViewController(repoDetailsController, animated: true)
  }

}

extension TrendingReposViewController: RepoItemCollectionViewCellDelegate {
  func didTapFavoriteButton(item: RepoCellViewModel) {
    viewModel.favoriteButtonAction(item: item)
    collectionView.reloadData()
    let action = item.isFavorite ? "added to" : "removed from"
    let message = "Successfully \(action) favorites."
    let alertController = makeAlertController(title: "Favorites", message: message)
    present(alertController, animated: true, completion: nil)
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
      alertController.dismiss(animated: true)
    }
  }
}
