//
//  Event.swift
//  VRef_v1
//
//  Created by William on 06/12/2022.
//

import Foundation

struct Event: Codable, Identifiable {
    let id: Int
    var name: String
    var symbol: String
    var timeStamp: TimeStamp
    var message: String
}
