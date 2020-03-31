//
//  File.swift
//  Zap Challenge
//
//  Created by Diego Gomes on 21/01/20.
//  Copyright © 2020 Diego Gomes. All rights reserved.
//

import UIKit

extension UITableView {
    func registerCell(_ cell: String) {
        register(UINib(nibName: cell, bundle: nil), forCellReuseIdentifier: cell)
    }
    
    func register<T: UITableViewCell>(_ cell: T.Type) where T:Reusable {
        register(cell.self, forCellReuseIdentifier: T.reuseId)
    }
}
