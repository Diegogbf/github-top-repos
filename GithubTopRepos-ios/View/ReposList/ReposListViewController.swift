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


class RepoTableViewCell: UITableViewCell {
    
    private lazy var repoNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var ownerLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var ownerAvatar: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var starsLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var watchersLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var popularityStackView: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .fill
        return stack
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 5
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        [starsLabel, watchersLabel].forEach { popularityStackView.addArrangedSubview($0) }
        [repoNameLabel, ownerLabel, popularityStackView].forEach { mainStackView.addArrangedSubview($0) }
        [mainStackView, ownerAvatar].forEach { contentView.addSubview($0) }
        
        ownerAvatar.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.height.width.equalTo(50)
            $0.leading.equalTo(16)
        }
        
        mainStackView.snp.makeConstraints {
            $0.leading.equalTo(ownerAvatar.snp.trailing).offset(16)
            $0.trailing.bottom.equalToSuperview().inset(16)
            $0.top.equalToSuperview().offset(16)
        }
    }
    
    func setup(repository: Repository) {
        ownerAvatar.downloadImage(url: repository.owner?.avatarURL)
        ownerLabel.text = "Owner: \(repository.owner!.login!)"
        repoNameLabel.text = "Repo Name: \(repository.name!)"
        starsLabel.text = "Stars: \(repository.stargazersCount!)"
        watchersLabel.text = "Followers: \(repository.watchersCount!)"
    }
}

