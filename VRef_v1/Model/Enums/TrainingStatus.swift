//
//  TrainingStatus.swift
//  VRef_v1
//
//  Created by William on 04/12/2022.
//

import Foundation

enum TrainingStatus: String, Codable {
    case Created = "Created",
         Recording = "Recording",
         Paused = "Paused",
         Processing = "Processing",
         Finished = "Finished"
}
