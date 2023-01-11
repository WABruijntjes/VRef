//
//  StartTrainingRequestBody.swift
//  VRef_v1
//
//  Created by William on 19/12/2022.
//

import Foundation

struct StartTrainingRequestBody: Encodable {
    let cameras: [Camera]
}
