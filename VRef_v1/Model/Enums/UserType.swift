//
//  UserType.swift
//  VRef_v1
//
//  Created by William on 29/11/2022.
//

import Foundation

enum UserType: String, Codable, Equatable, CaseIterable, Identifiable {
    var id: String { return self.rawValue }
    
    case Student = "Student",
         Instructor = "Instructor",
         Admin = "Admin",
         SuperAdmin = "SuperAdmin"
}
