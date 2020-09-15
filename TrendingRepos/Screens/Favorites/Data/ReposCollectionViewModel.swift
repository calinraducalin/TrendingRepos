//
//  ReposCollectionViewModel.swift
//  TrendingRepos
//
//  Created by Calin Radu Calin on 15/09/2020.
//  Copyright © 2020 Yummly. All rights reserved.
//

import UIKit

protocol ReposCollectionViewModel {
  var layoutType: LayoutType { get }
}

extension ReposCollectionViewModel {
  var repoCellName: String { .init(describing: RepoItemCollectionViewCell.self) }

  func makeLayout() -> UICollectionViewLayout {
    let columnsCount = layoutType.numberOfColumns
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                          heightDimension: .estimated(100))
    let subitem = NSCollectionLayoutItem(layoutSize: itemSize)
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize, subitem: subitem, count: columnsCount)
    let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
    let footer = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize, elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)
    let section = NSCollectionLayoutSection(group: group)
    section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
    section.interGroupSpacing = 10
    section.boundarySupplementaryItems = [footer]
    let layout = UICollectionViewCompositionalLayout(section: section)

    return layout
  }
}
