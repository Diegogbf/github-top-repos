//
//  UIViewController.swift
//  GithubTopRepos
//
//  Created by Diego Gomes on 30/03/20.
//  Copyright © 2020 Diego Gomes. All rights reserved.
//

import UIKit

extension UIViewController {
    func showErrorAlert(msg: String) {
        let alert = UIAlertController(title: "Erro", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
