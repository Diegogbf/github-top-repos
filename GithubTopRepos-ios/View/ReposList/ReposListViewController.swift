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
    
    // MARK: - Variables
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
        
        let indicator = UIActivityIndicatorView()
        indicator.tintColor = .black
        indicator.startAnimating()
        indicator.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        indicator.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50)
        
        tableView.tableFooterView = indicator
        tableView.tableFooterView?.isHidden = true
        return tableView
    }()
    
    let viewModel = ReposListViewModel()
    let disposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupBiding()
        viewModel.delegate = self
        viewModel.filterType.accept(.stars)
    }
    
    // MARK: - Setups
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

// MARK: - TableView data source and delegate
extension ReposListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepoTableViewCell.reuseId, for: indexPath) as! RepoTableViewCell
        cell.setup(repository: viewModel.repositories[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repo = viewModel.repositories[indexPath.row]
        if let link = URL(string: repo.htmlURL ?? "") {
            UIApplication.shared.open(link)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if viewModel.repositories.count - 3 == indexPath.row && viewModel.shouldPaginate {
            viewModel.fetchRepos()
        }
    }
}

// MARK: - RepoListDelegate
extension ReposListViewController: RepoListDelegate {
    func showError(message: String) {
        showErrorAlert(msg: message)
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func showLoader(_ show: Bool) {
        if tableView.numberOfRows(inSection: 0) > 0 {
            tableView.tableFooterView?.isHidden = !show
        } else {
            tableView.showLoader(show)
        }
    }
}
