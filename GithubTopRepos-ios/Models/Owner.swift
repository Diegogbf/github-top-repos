//
//  Owner.swift
//  GithubTopRepos
//
//  Created by Diego Gomes on 21/03/20.
//  Copyright © 2020 Diego Gomes. All rights reserved.
//

import Foundation

class Owner: Codable {
    var login: String?
    var id: Int?
    var nodeID: String?
    var avatarURL: String?
    var gravatarID: String?
    var url, receivedEventsURL: String?
    var type: String?

    enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case url
        case receivedEventsURL = "received_events_url"
        case type
    }
    
    init() {
        
    }

    init(login: String, id: Int, nodeID: String, avatarURL: String, gravatarID: String, url: String, receivedEventsURL: String, type: String) {
        self.login = login
        self.id = id
        self.nodeID = nodeID
        self.avatarURL = avatarURL
        self.gravatarID = gravatarID
        self.url = url
        self.receivedEventsURL = receivedEventsURL
        self.type = type
    }
}
