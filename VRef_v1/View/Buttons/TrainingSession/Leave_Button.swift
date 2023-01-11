//
//  Leave_Button.swift
//  VRef_v1
//
//  Created by William on 26/12/2022.
//

import SwiftUI

struct Leave_Button: View {
    @EnvironmentObject var trainingSessionVM: TrainingSessionViewModel

    @State var showingLeaveConfirmation: Bool = false
    @Binding var navigateToTrainingOverview: Bool
    
    var body: some View {
        Button(action: {
            showingLeaveConfirmation = true
        }) {
            Text("Leave training")
                .font(.system(size: 25, weight: .medium, design: .default))
                .foregroundColor(.white)
                .padding(.vertical, 5)
                .padding(.horizontal, 80)
        }
        .background {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color(.sRGB, red: 153/255, green: 15/255, blue: 238/255))
                .frame(width: 300)
                .clipped()
        }
        .alert("Are you sure you want to leave this training?", isPresented: $showingLeaveConfirmation){
            Button("   Leave Training   ", role: .destructive) {
                trainingSessionVM.showingExitTrainingForm = false
                trainingSessionVM.currentTraining = nil
                trainingSessionVM.selectedStudents = []
                navigateToTrainingOverview = true
             }
        }message: {
            Text("\nYou can still access this training from the main menu and continue it later.")
        }
    }
}
