//
//  TrendingTime.swift
//  TrendingRepos
//
//  Created by Calin Radu Calin on 14/09/2020.
//  Copyright © 2020 Yummly. All rights reserved.
//

import Foundation

enum TrendingTime: Int, CaseIterable {
  case lastDay, lastMonth, lastYear

  func makeCalendarComponent() -> Calendar.Component {
    let component: Calendar.Component
    switch self {
    case .lastDay:
      component = .day
    case .lastMonth:
      component = .month
    case .lastYear:
      component = .year
    }
    return component
  }

  func makeTitle() -> String {
    let title: String
    switch self {
    case .lastDay:
      title = "Day"
    case .lastMonth:
      title = "Month"
    case .lastYear:
      title = "Year"
    }
    return title
  }
}
