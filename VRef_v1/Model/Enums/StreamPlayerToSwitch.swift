//
//  StreamPlayerToSwitch.swift
//  VRef_v1
//
//  Created by William on 02/01/2023.
//

import Foundation

enum StreamPlayerToSwitch {
    case primary
    case secondary
    
    mutating func toggle() {
        switch self {
        case .primary:
            self = .secondary
        case .secondary:
            self = .primary
        }
    }
}
