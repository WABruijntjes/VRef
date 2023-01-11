//
//  StartTraining_Button.swift
//  VRef_v1
//
//  Created by William on 19/12/2022.
//

import SwiftUI

struct StartTraining_Button: View {
    
    @EnvironmentObject var trainingSessionVM: TrainingSessionViewModel
    @State private var navigateToTrainingScreen : Bool = false

    var body: some View {

        Button(action: {
            trainingSessionVM.createTraining()
            navigateToTrainingScreen = true
        }, label: {
            Text("Start Training")
                .padding(.all, 15)
                .font(.system(size: 25, weight: .bold, design: .default))
                .multilineTextAlignment(.leading)
            Image(systemName: "arrow.right")
                .imageScale(.large)
                .padding(.all, 10)
                .font(.system(size: 17, weight: .regular, design: .default))
        })
        .navigationDestination(isPresented: $navigateToTrainingScreen) {
            TrainingScreen()
        }
        .disabled(trainingSessionVM.startTrainingDisabled)
        .foregroundColor(trainingSessionVM.startTrainingDisabled ? Color(.systemGray4) : .white)
        .background {
            Capsule(style: .continuous)
                .fill(trainingSessionVM.startTrainingDisabled ? .gray : Color(.sRGB, red: 153/255, green: 15/255, blue: 238/255))
        }
    }
}
