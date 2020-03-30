//
//  CustomTableView.swift
//  GithubTopRepos
//
//  Created by Diego Gomes on 29/03/20.
//  Copyright © 2020 Diego Gomes. All rights reserved.
//

import UIKit

class CustomTableView: UITableView {
    private lazy var pullToRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self,
                                 action: #selector(pullToRefresh),
                                 for: .valueChanged)
        refreshControl.tintColor = .black
        return refreshControl
    }()
    
    private lazy var errorView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        
        let label = UILabel(frame: .zero)
        label.text = "Ocorreu um erro :( Tente Novamente"
        
        view.addSubview(label)
        label.snp.makeConstraints { $0.center.equalToSuperview() }
        
        return view
    }()
    
    func showLoader(_ show: Bool) {
        show ? pullToRefreshControl.beginRefreshing() : pullToRefreshControl.endRefreshing()
    }
    
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
}
