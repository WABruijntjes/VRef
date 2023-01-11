//
//  CreateTrainingRequestBody.swift
//  VRef_v1
//
//  Created by William on 14/12/2022.
//

import Foundation

struct CreateTrainingRequestBody: Encodable {
    let students: [Int]
    let instructorID: Int

    enum CodingKeys: String, CodingKey {
        case students
        case instructorID = "instructorId"
    }
}
