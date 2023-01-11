//
//  Organization.swift
//  VRef_v1
//
//  Created by William on 29/11/2022.
//

import Foundation

struct Organization: Identifiable, Codable{
    let id: Int
    var name: String
    let users: [User]?
}
