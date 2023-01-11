//
//  AccessToken.swift
//  VRef_v1
//
//  Created by William on 01/12/2022.
//

import Foundation

// MARK: - Token
struct AccessToken: Codable {
    let token: String
    let tokenType: String
    let expiresIn: Int
}
