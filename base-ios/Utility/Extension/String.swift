//
//  String+Covert.swift
//  Zap Challenge
//
//  Created by Diego Gomes on 20/01/20.
//  Copyright © 2020 Diego Gomes. All rights reserved.
//

import Foundation

extension String {
    
    var toFloat: Float {
        get {
            return (self as NSString).floatValue
        }
    }
}
