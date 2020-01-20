//
//  ParameterEncoding.swift
//  base-ios
//
//  Created by Diego Gomes on 20/01/20.
//  Copyright © 2020 Diego Gomes. All rights reserved.
//

import Foundation

public typealias Parameters = [String: Any]

public protocol ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

public enum NetworkError: String, Error {
    case parametersAreNil = "No parameters"
    case encodingFailed = "Encoding failed"
    case missingURL = "URL is nil"
}
