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
    case followers
    
    var filterTag: String {
        switch self {
        case .stars:
            return "stars"
        case .followers:
            return "watchers"
        }
    }
}

class ReposListViewModel {
    // MARK: - Variables
    var repositories = BehaviorRelay<[Repository]>(value: [])
    var currentPage: Int = 0
    var filterType = BehaviorRelay<RepoListOrderType>(value: .stars)
    
    // MARK: - Api Request
    func fetchRepos(onSuccess: @escaping ()->(), onError: @escaping(String)->()) {
        let request = ReposListHeader(sort: filterType.value.filterTag, page: currentPage)
        ServiceLayer.request(route: Router.listRepos(request: request), onSuccess: { (response: RepositoriesList) in
            self.repositories.accept(response.items ?? [])
            onSuccess()
        }) { (msg) in
            onError(msg)
        }
    }
}
