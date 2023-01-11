//
//  Camera.swift
//  VRef_v1
//
//  Created by William on 19/12/2022.
//

import Foundation

struct Camera: Encodable {
    let name, url, username, password: String
    let captureMode: String
}
