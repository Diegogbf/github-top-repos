//
//  LoaderCell.swift
//  GithubTopRepos
//
//  Created by Diego Gomes on 30/03/20.
//  Copyright © 2020 Diego Gomes. All rights reserved.
//

import UIKit

class LoaderCell: UITableViewCell, Reusable {
    
    static var reuseId: String {
        return String(describing: self)
    }

    lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.tintColor = .black
        return indicator
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
        contentView.addSubview(indicator)
        indicator.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(8)
            $0.bottom.equalToSuperview().inset(8)
        }
    }
}

