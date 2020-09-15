//
//  Repository.swift
//  TrendingRepos
//
//  Created by Calin Radu Calin on 15/09/2020.
//  Copyright © 2020 Yummly. All rights reserved.
//

import RealmSwift

class Repository: Object {
  @objc dynamic var id = 0
  @objc dynamic var forksCount = 0
  @objc dynamic var stargazersCount = 0
  @objc dynamic var name = ""
  @objc dynamic var fullName = ""
  @objc dynamic var details = ""
  @objc dynamic var language = ""
  @objc dynamic var imageURLString = ""
  @objc dynamic var cloneURLString = ""
  @objc dynamic var createdAt = Date()

  func update(with item: RepoItem) {
    id = item.id
    forksCount = item.forksCount ?? forksCount
    stargazersCount = item.stargazersCount ?? stargazersCount
    name = item.name ?? name
    fullName = item.fullName ?? fullName
    details = item.description ?? details
    language = item.language ?? language
    imageURLString = item.owner?.avatarUrl?.absoluteString ?? imageURLString
    cloneURLString = item.cloneUrl?.absoluteString ?? cloneURLString
    createdAt = item.createdAt ?? createdAt
  }
}
