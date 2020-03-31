//
//  CustomTableView.swift
//  GithubTopRepos
//
//  Created by Diego Gomes on 29/03/20.
//  Copyright © 2020 Diego Gomes. All rights reserved.
//

import UIKit

class CustomTableView: UITableView {
    
    // MARK: - Variables
    private lazy var pullToRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self,
                                 action: #selector(pullToRefresh),
                                 for: .valueChanged)
        refreshControl.tintColor = .black
        return refreshControl
    }()
    
    var pullToRefreshAction: (()->())? {
        didSet {
            if pullToRefreshAction != nil {
                refreshControl = pullToRefreshControl
            }
        }
    }
    
    @objc private func pullToRefresh() {
        pullToRefreshAction?()
    }
    
    func showLoader(_ show: Bool) {
        show ? pullToRefreshControl.beginRefreshing() : pullToRefreshControl.endRefreshing()
    }
}
