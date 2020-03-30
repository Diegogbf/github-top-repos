//
//  RequestHeader.swift
//  GithubTopRepos
//
//  Created by Diego Gomes on 21/03/20.
//  Copyright © 2020 Diego Gomes. All rights reserved.
//

import Foundation

struct ReposListHeader: Codable {
    let topic: String = "swift"
    let order: String = "asc"
    var sort: String
    var page: Int
    var itemsPerPage: Int = 20
    
    enum CodingKeys: String, CodingKey {
        case topic = "q"
        case order
        case sort
        case page
        case itemsPerPage = "per_page"
    }
}
