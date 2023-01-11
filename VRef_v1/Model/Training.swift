//
//  Training.swift
//  VRef_v1
//
//  Created by William on 04/12/2022.
//

import Foundation

// MARK: - Training
struct Training: Identifiable, Codable {
    let id: Int
    let creationDateTime: String
    let status: TrainingStatus
    let instructor: User
    var students: [User]
    var events: [Event]?
    let altitudes: [Altitude]?
    
    var parsedDate: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSS"

        let date = dateFormatter.date(from: creationDateTime)

        guard let date = date else {
            return Date()
        }

        return date
    }

    var completeDateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "dd MMMM yyyy"

        let date = dateFormatter.string(from: parsedDate)

        return date
    }
//
//    var readableTimeString: String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
//        dateFormatter.dateFormat = "HH:mm"
//
//        let date = dateFormatter.string(from: parsedDate)
//
//        return date
//    }
}
