////
////  Router.swift
////  base-ios
////
////  Created by Diego Gomes on 20/01/20.
////  Copyright © 2020 Diego Gomes. All rights reserved.
////
//
import Foundation

enum Router: String {
    case getSomething
}

extension Router: EndPointType {
    var baseURL: URL {
        return URL(string: apiURL)!
    }
    
    var path: String {
        switch self {
        case .getSomething:
            return EndPoint.getSomething.rawValue
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

