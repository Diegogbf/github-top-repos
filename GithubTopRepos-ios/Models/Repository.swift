//
//  Repository.swift
//  GithubTopRepos
//
//  Created by Diego Gomes on 21/03/20.
//  Copyright © 2020 Diego Gomes. All rights reserved.
//

import Foundation

class Repository: Codable {
    let id: Int
    let nodeID, name, fullName: String
    let owner: Owner
    let itemPrivate: Bool
    let htmlURL: String
    let itemDescription: String
    let fork: Bool
    let url: String
    let createdAt, updatedAt, pushedAt: Date
    let homepage: String
    let size, stargazersCount, watchersCount: Int
    let language: String
    let forksCount, openIssuesCount: Int
    let masterBranch, defaultBranch: String
    let score: Double

    enum CodingKeys: String, CodingKey {
        case id
        case nodeID = "node_id"
        case name
        case fullName = "full_name"
        case owner
        case itemPrivate = "private"
        case htmlURL = "html_url"
        case itemDescription = "description"
        case fork, url
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case pushedAt = "pushed_at"
        case homepage, size
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case language
        case forksCount = "forks_count"
        case openIssuesCount = "open_issues_count"
        case masterBranch = "master_branch"
        case defaultBranch = "default_branch"
        case score
    }

    init(id: Int, nodeID: String, name: String, fullName: String, owner: Owner, itemPrivate: Bool, htmlURL: String, itemDescription: String, fork: Bool, url: String, createdAt: Date, updatedAt: Date, pushedAt: Date, homepage: String, size: Int, stargazersCount: Int, watchersCount: Int, language: String, forksCount: Int, openIssuesCount: Int, masterBranch: String, defaultBranch: String, score: Double) {
        self.id = id
        self.nodeID = nodeID
        self.name = name
        self.fullName = fullName
        self.owner = owner
        self.itemPrivate = itemPrivate
        self.htmlURL = htmlURL
        self.itemDescription = itemDescription
        self.fork = fork
        self.url = url
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.pushedAt = pushedAt
        self.homepage = homepage
        self.size = size
        self.stargazersCount = stargazersCount
        self.watchersCount = watchersCount
        self.language = language
        self.forksCount = forksCount
        self.openIssuesCount = openIssuesCount
        self.masterBranch = masterBranch
        self.defaultBranch = defaultBranch
        self.score = score
    }
}

