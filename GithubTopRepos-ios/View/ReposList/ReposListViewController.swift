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
        let segmentControl = UISegmentedControl(items: [RepoListOrderType.stars.rawValue, RepoListOrderType.watchers.rawValue])
        segmentControl.backgroundColor = .white
        segmentControl.selectedSegmentIndex = 0
        return segmentControl
    }()
    
    private lazy var tableView: CustomTableView = {
        let tableView = CustomTableView(frame: .zero)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RepoTableViewCell.self)
        tableView.register(LoaderCell.self)
        return tableView
    }()
    
    let viewModel = ReposListViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupBiding()
        viewModel.delegate = self
        viewModel.filterType.accept(.stars)
    }
    
    private func setup() {
        navigationItem.titleView = segmentControl
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        tableView.pullToRefreshAction = { [weak self] in
            self?.viewModel.resetPagination()
            self?.tableView.reloadData()
            self?.viewModel.fetchRepos()
        }
    }
    
    private func setupBiding() {
        segmentControl
            .rx
            .selectedSegmentIndex
            .map{ $0 == 0 ? RepoListOrderType.stars : RepoListOrderType.watchers }
            .bind(to: viewModel.filterType)
            .disposed(by: disposeBag)
    }
}

extension ReposListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? viewModel.repositories.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: RepoTableViewCell.reuseId, for: indexPath) as! RepoTableViewCell
            cell.setup(repository: viewModel.repositories[indexPath.row])
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: LoaderCell.reuseId, for: indexPath) as! LoaderCell
            cell.indicator.startAnimating()
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.isPaginating ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repo = viewModel.repositories[indexPath.row]
        if let link = URL(string: repo.htmlURL ?? "") {
          UIApplication.shared.open(link)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > (scrollView.contentSize.height - scrollView.frame.height) {
            if !viewModel.repositories.isEmpty && viewModel.shouldPaginate && !viewModel.isPaginating {
                viewModel.isPaginating = true
                viewModel.fetchRepos()
            }
        }
    }
}

extension ReposListViewController: RepoListDelegate {
    func showError(message: String) {
        showErrorAlert(msg: message)
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func showLoader(_ show: Bool) {
        if !viewModel.isPaginating {
            tableView.showLoader(show)
        }
    }
}
