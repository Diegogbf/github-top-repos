//
//  ResposListViewModel.swift
//  GithubTopRepos
//
//  Created by Diego Gomes on 21/03/20.
//  Copyright © 2020 Diego Gomes. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

enum RepoListOrderType: String {
    case stars
    case watchers
}

protocol RepoListDelegate: class {
    func showError(message: String)
    func reloadData()
    func showLoader(_ show: Bool)
}

class ReposListViewModel {
    // MARK: - Variables
    var repositories = [Repository]()
    var currentPage: Int = 0
    var filterType = BehaviorRelay<RepoListOrderType>(value: .stars)
    var loading = PublishSubject<Bool>()
    let bag = DisposeBag()
    var isPaginating = false {
        didSet {
            self.delegate?.reloadData()
        }
    }
    var shouldPaginate = true
    
    weak var delegate: RepoListDelegate?
    
    init() {
        setupObservables()
    }
    
    func resetPagination() {
        currentPage = 0
        shouldPaginate = true
        isPaginating = false
        repositories.removeAll()
    }
    
    private func setupObservables() {
        filterType
            .asObservable()
            .subscribe(onNext: { [weak self] _ in
                self?.resetPagination()
                self?.delegate?.reloadData()
                self?.fetchRepos()
            }
        ).disposed(by: bag)
    }
    
    // MARK: - Api Request
    func fetchRepos() {
        if shouldPaginate {
            let request = ReposListHeader(sort: filterType.value.rawValue, page: currentPage)
            
            delegate?.showLoader(true)
            ServiceLayer.request(route: Router.listRepos(request: request), onSuccess: { (response: RepositoriesList) in
                self.delegate?.showLoader(false)
                self.repositories.append(contentsOf: response.items ?? [])
                self.shouldPaginate = (response.items?.count ?? 0) != 0
                self.currentPage += 1
                self.isPaginating = false
            }) { (msg) in
                self.delegate?.showLoader(false)
                self.isPaginating = false
                self.delegate?.showError(message: msg)
            }
        }
    }
}
