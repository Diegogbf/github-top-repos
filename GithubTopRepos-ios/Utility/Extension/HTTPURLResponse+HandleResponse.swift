//
//  URLHttpResponse+HandleResponse.swift
//  base-ios
//
//  Created by Diego Gomes on 20/01/20.
//  Copyright © 2020 Diego Gomes. All rights reserved.
//

import Foundation

extension HTTPURLResponse {
    func handleResponse() -> Result<String> {
        switch self.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        default:
        return .failure(NetworkResponse.badRequest.rawValue)
        }
    }
}
