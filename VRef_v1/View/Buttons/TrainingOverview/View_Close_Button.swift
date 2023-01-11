//
//  View_Button.swift
//  VRef_v1
//
//  Created by William on 26/10/2022.
//

import SwiftUI

struct View_Close_Button: View {
    
    @EnvironmentObject var trainingOverviewVM: TrainingOverviewViewModel
    
    var training: Training
    
    var body: some View {
        Button(action: {
            withAnimation(.easeIn(duration: 0.3)) {
                trainingOverviewVM.showingEvents = false
                if(trainingOverviewVM.openEventsTraining?.id == training.id) {
                    trainingOverviewVM.openEventsTrainingID = -1
                    trainingOverviewVM.openEventsTraining = nil
                }else{
                    trainingOverviewVM.getEventsOfTraining(trainingID: training.id)
                    trainingOverviewVM.showingEvents = true
                    trainingOverviewVM.openEventsTrainingID = training.id
                }
            }
        }) {
            Image(systemName: trainingOverviewVM.openEventsTrainingID == training.id ? "xmark" : "eye")
                .imageScale(.large)
                .padding(.horizontal, 5)
                .font(.system(size: 17, weight: .regular, design: .default))
            Text(trainingOverviewVM.openEventsTrainingID == training.id ? "Close" : "View")
                .padding(.all, 10)
                .font(.system(size: 25, weight: .regular, design: .default))
                .multilineTextAlignment(.leading)
        }
        .foregroundColor(.white)
        .background {
            Capsule(style: .continuous)
                .foregroundColor(trainingOverviewVM.openEventsTrainingID == training.id ? Color(.sRGB, red: 253/255, green: 77/255, blue: 77/255) : Color(.sRGB, red: 10/255, green: 90/255, blue: 254/255))
                .clipped()
                .frame(maxWidth: 180)
        }
    }
}
