//
//  PersistanceManager.swift
//  TrendingRepos
//
//  Created by Calin Radu Calin on 15/09/2020.
//  Copyright © 2020 Yummly. All rights reserved.
//

import RealmSwift

class PersistanceManager {

  private lazy var realm: Realm = {
    do {
      return try Realm()
    } catch {
     fatalError("Realm Setup Error")
    }
  }()

  private lazy var repositories: Results<Repository> = realm.objects(Repository.self)

  var favoriteRepos: [Repository] { repositories.map { $0 } }

  func getRepository(id: Int) -> Repository? { repositories.first(where: { $0.id == id }) }

  func isFavorite(item: RepoItem) -> Bool { getRepository(id: item.id) != nil }

  func addToFavorites(item: RepoItem) {
    guard !isFavorite(item: item) else { return }
    let repository = Repository()
    repository.update(with: item)
    try? realm.write {
      realm.add(repository)
    }
  }

  func removeFromFavorites(itemWithID id: Int) {
    guard let repository = getRepository(id: id) else { return }
    try? realm.write {
      realm.delete(repository)
    }
  }


}
