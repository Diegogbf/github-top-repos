//
//  Float.swift
//  Zap Challenge
//
//  Created by Diego Gomes on 21/01/20.
//  Copyright © 2020 Diego Gomes. All rights reserved.
//

import Foundation

extension Float {
    
    var toBRL: String {
        get {
            return String(format: "R$ %.2f", self)
        }
    }
}
