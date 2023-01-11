//
//  SaveAndFinish_Button.swift
//  VRef_v1
//
//  Created by William on 26/12/2022.
//

import SwiftUI

struct SaveAndFinish_Button: View {

    @EnvironmentObject var trainingSessionVM: TrainingSessionViewModel
    @State var showingSaveFinishConfirmation: Bool = false
    @Binding var navigateToTrainingOverview: Bool
    
    var body: some View {
        Button(action: {
            showingSaveFinishConfirmation = true
        }) {
            Text("Save & finish training")
                .font(.system(size: 25, weight: .medium, design: .default))
                .foregroundColor(.white)
                .padding(.vertical, 15)
                .padding(.horizontal, 80)
        }
        .background {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color(.sRGB, red: 153/255, green: 15/255, blue: 238/255))
                .frame(width: 300)
                .clipped()
        }
        .alert("Are you sure you want to finish this training?", isPresented: $showingSaveFinishConfirmation){
            Button("Save & Finish Training", role: .destructive) {
                trainingSessionVM.showingExitTrainingForm = false
                trainingSessionVM.stopTraining()
                trainingSessionVM.currentTraining = nil
                trainingSessionVM.selectedStudents = []
                navigateToTrainingOverview = true
             }
        }message: {
            Text("\nAll marked events can’t be changed after finishing the training")
        }
    }
}
