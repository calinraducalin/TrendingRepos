//
//  UIViewController+Alert.swift
//  TrendingRepos
//
//  Created by Calin Radu Calin on 15/09/2020.
//  Copyright © 2020 Yummly. All rights reserved.
//

import UIKit

extension UIViewController {

  func makeAlertController(style: UIAlertController.Style = .alert, title: String? = nil, message: String? = nil, actions: [UIAlertAction] = []) -> UIAlertController {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
    actions.forEach{ alertController.addAction($0) }
    return alertController
  }

  func showAlert(title: String?, message: String?) {
    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    let alertController = makeAlertController(title: title, message: message, actions: [okAction])
    present(alertController, animated: true, completion: nil)
  }
}
