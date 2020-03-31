//
//  RepoListTableViewCell.swift
//  GithubTopRepos
//
//  Created by Diego Gomes on 30/03/20.
//  Copyright © 2020 Diego Gomes. All rights reserved.
//

import UIKit

class RepoTableViewCell: UITableViewCell, Reusable {
    
    static var reuseId: String {
        return String(describing: self)
    }
    
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
        stack.distribution = .fillProportionally
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
        selectionStyle = .none
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
