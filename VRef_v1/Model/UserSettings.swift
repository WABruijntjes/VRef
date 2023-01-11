//
//  UserSettings.swift
//  VRef_v1
//
//  Created by William on 12/12/2022.
//

import Foundation
import Combine

class UserSettings: ObservableObject {
    @Published var loggedInUser: User?
    
    init() {
        do {
            self.loggedInUser = try UserDefaults.standard.getObject(forKey: "loggedInUser", castTo: User.self)
        } catch {
            print(error)
        }
    }
}
