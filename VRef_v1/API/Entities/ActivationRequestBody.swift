//
//  ActivationRequestBody.swift
//  VRef_v1
//
//  Created by William on 09/01/2023.
//

import Foundation

struct ActivationRequestBody: Codable {
    let activationCode: String
    let password: String
}
