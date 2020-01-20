//
//  EndPointType.swift
//  base-ios
//
//  Created by Diego Gomes on 20/01/20.
//  Copyright © 2020 Diego Gomes. All rights reserved.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}

