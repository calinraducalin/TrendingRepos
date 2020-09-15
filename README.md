# TrendingRepos
Displays the trending repositories on GitHub

Implementation Details

* This is a small demo app that can run on both iOS and iPadOS
* Trending and Favorite screen uses a collection view with UICollectionViewCompositionalLayout to display the items
* On iPad the items are displayed using two columns, while on iPhone the items are displayed using only one column
* RealmSwift was used in order to save the favorites repositories locally
* Repository Details screen is implemented using SwiftUI
* Imaged are cached using Kingfisher
* No networking library was used
