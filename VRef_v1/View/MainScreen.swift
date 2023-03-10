//
//  MainScreen.swift
//  VRef_v1
//
//  Created by William on 26/10/2022.
//

import SwiftUI

struct MainScreen: View {
    
    @StateObject var userSettings = UserSettings()
    @StateObject var trainingOverviewVM = TrainingOverviewViewModel()
    @StateObject var trainingSessionVM = TrainingSessionViewModel()
    @StateObject var adminPanelVM = AdminPanelViewModel()
    
    var body: some View {
        VStack(spacing: 0){
            TopBar()
                .environmentObject(userSettings)
                .environmentObject(trainingOverviewVM)
                .environmentObject(trainingSessionVM)
            ZStack{
                if(userSettings.loggedInUser?.userType == .Admin || userSettings.loggedInUser?.userType == .SuperAdmin){
                    AdminPanel()
                        .environmentObject(userSettings)
                        .environmentObject(adminPanelVM)
                }else{
                    TrainingOverview()
                        .environmentObject(userSettings)
                        .environmentObject(trainingOverviewVM)
                        .environmentObject(trainingSessionVM)
                        .environmentObject(adminPanelVM)
                }
            }
        }
    }
}
