//
//  TrendingFeed.swift
//  TrendingRepos
//
//  Created by Calin Radu Calin on 13/09/2020.
//  Copyright © 2020 Yummly. All rights reserved.
//

import Foundation


struct TrendingFeed: Codable {
  let totalCount: Int?
  let incompleteResults: Bool?
  let items: [RepoItem]?
}

struct RepoItem: Codable {
  let id: Int
  let name: String?
  let fullName: String?
  let description: String?
  let language: String?
  let forksCount: Int?
  let stargazersCount: Int?
  let createdAt: Date?
  let owner: Owner?
}

struct Owner: Codable {
  let avatarUrl: URL?
}
