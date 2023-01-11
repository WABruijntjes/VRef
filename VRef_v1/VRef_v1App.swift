//
//  VRef_v1App.swift
//  VRef_v1
//
//  Created by William on 25/10/2022.
//

import SwiftUI

@main
struct VRef_v1App: App {
    
    @StateObject var loginVM = LoginViewModel()
    
    var body: some Scene {
        WindowGroup {
            if loginVM.isAuthenticated{
                MainScreen()
                    .environmentObject(loginVM)
                    .preferredColorScheme(.dark)

            }else{
                Login()
                    .environmentObject(loginVM)
                    .preferredColorScheme(.dark)
            }
        }
    }
}
