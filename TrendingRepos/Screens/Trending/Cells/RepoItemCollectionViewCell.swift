//
//  RepoItemCollectionViewCell.swift
//  TrendingRepos
//
//  Created by Calin Radu Calin on 13/09/2020.
//  Copyright © 2020 Yummly. All rights reserved.
//

import UIKit
import Kingfisher

protocol RepoItemCollectionViewCellDelegate: AnyObject {
  func didTapFavoriteButton(item: RepoCellViewModel)
}

class RepoItemCollectionViewCell: UICollectionViewCell {

  weak var delegate: RepoItemCollectionViewCellDelegate?
  private var item: RepoCellViewModel?
  @IBOutlet private weak var imageView: UIImageView!
  @IBOutlet private weak var titleLabel: UILabel!
  @IBOutlet private weak var subtitleLabel: UILabel!
  @IBOutlet private weak var favoriteButton: UIButton!
  @IBOutlet private weak var imageHeightConstraint: NSLayoutConstraint!

  override func awakeFromNib() {
    super.awakeFromNib()
    imageView.layer.cornerRadius = imageHeightConstraint.constant / 2
  }


  func update(with item: RepoCellViewModel) {
    self.item = item
    titleLabel.text = item.title
    subtitleLabel.text = item.subtitle
    favoriteButton.isSelected = item.isFavorite
    imageView.kf.setImage(with: item.imageURL)
  }


  @IBAction func favoriteButtonAction(_ sender: Any) {
    guard let item = item else { return }
    delegate?.didTapFavoriteButton(item: item)
  }





}
