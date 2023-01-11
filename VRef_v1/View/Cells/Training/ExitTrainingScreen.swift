//
//  ExitTrainingScreen.swift
//  VRef_v1
//
//  Created by William on 26/12/2022.
//

import SwiftUI

struct ExitTrainingScreen: View {    
    @EnvironmentObject var trainingSessionVM: TrainingSessionViewModel
    
    @Binding var navigateToTrainingOverview: Bool
    
    
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                HStack {
                    Text("Finish & save training")
                        .font(.largeTitle.weight(.bold))
                    Spacer()
                    Image(systemName: "xmark")
                        .imageScale(.large)
                        .font(.largeTitle)
                        .onTapGesture {
                            trainingSessionVM.showingExitTrainingForm = false
                        }
                }
                .padding()
            }
            .padding(.bottom)
            VStack(spacing: 25) {
                Text("Save this training as:")
                    .font(.title3)
                HStack{
                    Text(trainingSessionVM.currentTraining?.parsedDate ?? Date(), format: .dateTime.day().month(.wide).year())
                    Text(" | ")
                    Text(trainingSessionVM.currentTraining?.parsedDate ?? Date(), format: .dateTime.hour().minute())
                }
                .font(.largeTitle.weight(.bold))
                .padding(.vertical)
                Text("NOTE: After saving you will not be able to make anymore changes to the marked events. Video streams are not saved")
                    .font(.callout.weight(.semibold))
            }
            .foregroundColor(Color(.sRGB, red: 132/255, green: 132/255, blue: 132/255))
            .padding(.bottom, 50)
            VStack(spacing: 25) {
                SaveAndFinish_Button(navigateToTrainingOverview: $navigateToTrainingOverview)
                Leave_Button(navigateToTrainingOverview: $navigateToTrainingOverview)
                Cancel_Button()
                Spacer()
//                Discard_Button(navigateToTrainingOverview: $navigateToTrainingOverview, showingExitTrainingForm: $showingExitTrainingForm)
                
            }
            .padding()
            Spacer()
        }
        .padding(.all)
    }
}
