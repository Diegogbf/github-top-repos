////
////  Router.swift
////  base-ios
////
////  Created by Diego Gomes on 20/01/20.
////  Copyright © 2020 Diego Gomes. All rights reserved.
////
//
import Foundation

enum Result<String> {
    case success
    case failure(String)
}

enum NetworkResponse: String {
    case success
    case authenticationError = "Auth Error"
    case badRequest = "Bad Request"
    case unableToDecode = "Unable to decode response"
}

enum Router {
    case getSomething
}

extension Router: EndPointType {
    var baseURL: URL {
        return URL(string: "www.google.com")!
    }
    
    var path: String {
        switch self {
        case .getSomething:
            return "/search"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getSomething:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .getSomething:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}

