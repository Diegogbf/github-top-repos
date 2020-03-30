//
//  ViewController.swift
//  base-ios
//
//  Created by Diego Gomes on 20/01/20.
//  Copyright © 2020 Diego Gomes. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class ReposListViewController: UIViewController {
    
    private lazy var segmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: [RepoListOrderType.stars.rawValue, RepoListOrderType.followers.rawValue])
        segmentControl.backgroundColor = .white
        return segmentControl
    }()
    
    private lazy var tableView: CustomTableView = {
        let tableView = CustomTableView(frame: .zero)
        tableView.register(RepoTableViewCell.self, forCellReuseIdentifier: "RepoTableViewCell")
        return tableView
    }()
    
    let viewModel = ReposListViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetchData()
        setupBiding()
    }
    
    private func setup() {
        navigationItem.titleView = segmentControl
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        tableView.pullToRefreshAction = { [weak self] in
            self?.fetchData()
        }
    }
    
    private func setupBiding() {
        segmentControl
            .rx
            .selectedSegmentIndex
            .map{ $0 == 0 ? RepoListOrderType.stars : RepoListOrderType.followers }
            .bind(to: viewModel.filterType)
            .disposed(by: disposeBag)
        
        viewModel
            .repositories
            .bind(to: tableView.rx.items(cellIdentifier: "RepoTableViewCell", cellType: RepoTableViewCell.self)) { row, element, cell in
                cell.setup(repository: element)
        }.disposed(by: disposeBag)
    }
    
    private func fetchData() {
        tableView.showLoader(true)
        viewModel.fetchRepos(onSuccess: { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.showLoader(false)
                self?.tableView.reloadData()
            }
        }) { _ in  }
    }
}

