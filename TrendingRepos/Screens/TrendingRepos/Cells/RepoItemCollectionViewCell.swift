//
//  RepoItemCollectionViewCell.swift
//  TrendingRepos
//
//  Created by Calin Radu Calin on 13/09/2020.
//  Copyright © 2020 Yummly. All rights reserved.
//

import UIKit
import Kingfisher

class RepoItemCollectionViewCell: UICollectionViewCell {

  @IBOutlet private weak var imageView: UIImageView!
  @IBOutlet private weak var titleLabel: UILabel!
  @IBOutlet private weak var subtitleLabel: UILabel!
  @IBOutlet private weak var favoriteButton: UIButton!
  @IBOutlet private weak var imageHeightConstraint: NSLayoutConstraint!

  override func awakeFromNib() {
    super.awakeFromNib()
    imageView.layer.cornerRadius = imageHeightConstraint.constant / 2
  }


  func update(with viewModel: RepoCellViewModel) {
    titleLabel.text = viewModel.title
    subtitleLabel.text = viewModel.subtitle
    favoriteButton.isSelected = viewModel.isFavorite
    imageView.kf.setImage(with: viewModel.imageURL)
  }


  @IBAction func favoriteButtonAction(_ sender: Any) {
    
  }



}
