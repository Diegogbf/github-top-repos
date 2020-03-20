//
//  NetworkResponse.swift
//  base-ios
//
//  Created by Diego Gomes on 19/03/20.
//  Copyright © 2020 Diego Gomes. All rights reserved.
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
