////
////  Router.swift
////  base-ios
////
////  Created by Diego Gomes on 20/01/20.
////  Copyright © 2020 Diego Gomes. All rights reserved.
////
//
import Foundation

enum Router {
    case listRepos(request: ReposListHeader)
}

extension Router: EndPointType {
    var baseURL: URL {
        return URL(string: apiURL)!
    }
    
    var path: String {
        switch self {
        case .listRepos:
            return EndPoint.listRepos.rawValue
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .listRepos:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .listRepos(let request):
            return .requestParameters(bodyParameters: nil, urlParameters: request.dictionary)
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}

