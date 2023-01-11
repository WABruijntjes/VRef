//
//  Continue_Button.swift
//  VRef_v1
//
//  Created by William on 24/12/2022.
//

import SwiftUI

struct Continue_Button: View {
    @EnvironmentObject var trainingSessionVM: TrainingSessionViewModel
    @State private var navigateToTrainingScreen : Bool = false

    var training: Training
    
    var body: some View {
        Button(action: {
            trainingSessionVM.continueTraining(training: training)
            navigateToTrainingScreen = true
            
        }) {
            Text("Continue")
                .padding(.all, 10)
                .font(.system(size: 20, weight: .regular, design: .default))
                .padding(.horizontal)
                .foregroundColor(.white)
        }
        .background {
            Capsule(style: .continuous)
            .foregroundColor(Color(.sRGB, red: 88/255, green: 210/255, blue: 101/255))
        }
        .navigationDestination(isPresented: $navigateToTrainingScreen) {
            TrainingScreen()
        }
    }
}
