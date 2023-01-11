//
//  User.swift
//  VRef_v1
//
//  Created by William on 29/11/2022.
//

import Foundation

// MARK: - User
struct User: Identifiable, Codable {
    let id: Int
    var email: String
    var firstName: String
    var lastName: String
    var organization: Organization
    var userType: UserType
    
    var fullName: String {
        firstName.capitalized + " " + lastName.capitalized
    }
    
    var fullName_shortenedSurName: String {
        "\(firstName.capitalized) \(lastName[0].capitalized)."
    }
    
    var fullName_shortenedFirstName: String {
        "\(firstName[0].capitalized). \(lastName.capitalized)"
    }
}
