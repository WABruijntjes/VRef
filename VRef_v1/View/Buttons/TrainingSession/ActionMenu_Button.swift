//
//  ActionMenu_Button.swift
//  VRef_v1
//
//  Created by William on 22/12/2022.
//

import SwiftUI

struct ActionMenu_Button: View {
    @EnvironmentObject var trainingSessionVM: TrainingSessionViewModel

    var buttonImage: String
    var buttonAction: String
    
    @Binding var streamPlayerToSwitch: StreamPlayerToSwitch
    @Binding var isExpanded: Bool
    
    var body: some View {
        Button(action: {
            switch buttonAction{
            case "addEvent":
                trainingSessionVM.showingAddEventForm = true
            case "switchCamera1":
                streamPlayerToSwitch = .primary
                trainingSessionVM.showingSwitchCameraForm = true
            case "switchCamera2":
                streamPlayerToSwitch = .secondary
                trainingSessionVM.showingSwitchCameraForm = true
            case "exitTraining":
                trainingSessionVM.showingExitTrainingForm = true
            default:
                print("No corresponding actions to this button action")
            }
            
            isExpanded.toggle()
        }) {
            ZStack {
                Circle()
                    .foregroundColor(Color(.sRGB, red: 153/255, green: 15/255, blue: 238/255))
                    .frame(width: 50, height: 50)
                ZStack{
                    Image(systemName: buttonImage)
                        .imageScale(.large)
                        .foregroundColor(.white)
                    switch buttonAction{
                    case "switchCamera1":
                        Text("1")
                            .foregroundColor(.white)
                            .offset(x: 10,y: -10)
                            .font(.body.weight(.bold))
                            .shadow(color: .black.opacity(1), radius: 1, x: 0, y: 3)
                        
                    case "switchCamera2":
                        Text("2")
                            .foregroundColor(.white)
                            .offset(x: 10,y: -10)
                            .font(.body.weight(.bold))
                            .shadow(color: .black.opacity(1), radius: 1, x: 0, y: 3)
                    default:
                        Text("")
                    }
                }
            }
        }.shadow(color: Color.black.opacity(0.3),
                 radius: 3,
                 x: 3,
                 y: 3)
    }
}
