//
//  Action_Button.swift
//  VRef_v1
//
//  Created by William on 06/11/2022.
//

import SwiftUI

struct Action_Button: View {
    @EnvironmentObject var trainingSessionVM: TrainingSessionViewModel
    
    @State var isExpanded = false
    @Binding var streamPlayerToSwitch: StreamPlayerToSwitch
    
    var body: some View {
        VStack{
            Spacer()
            HStack{
                Spacer()
                ZStack {
                    if isExpanded {
                        ActionMenu_Button(buttonImage: "plus", buttonAction:"addEvent", streamPlayerToSwitch: $streamPlayerToSwitch, isExpanded: $isExpanded)
                            .offset(x: 10, y: -100)
                            .transition(.offset(x: -10, y: 100))
                        ActionMenu_Button(buttonImage: "arrow.triangle.2.circlepath.camera.fill", buttonAction: "switchCamera1", streamPlayerToSwitch: $streamPlayerToSwitch, isExpanded: $isExpanded)
                            .offset(x: -50, y: -90)
                            .transition(.offset(x: 50, y: 90))
                        ActionMenu_Button(buttonImage: "arrow.triangle.2.circlepath.camera.fill", buttonAction: "switchCamera2", streamPlayerToSwitch: $streamPlayerToSwitch, isExpanded: $isExpanded)
                            .offset(x: -90, y: -45)
                            .transition(.offset(x: 90, y: 45))
                        ActionMenu_Button(buttonImage: "rectangle.portrait.and.arrow.forward", buttonAction:"exitTraining", streamPlayerToSwitch: $streamPlayerToSwitch, isExpanded: $isExpanded)
                            .offset(x: -115, y: 10)
                            .transition(.offset(x: 115, y: -10))
                    }
                    Button(action: {
                        withAnimation {
                            isExpanded.toggle()
                        }
                    }, label: {
                        Image(systemName: "line.3.horizontal")
                            .font(.system(.largeTitle))
                            .frame(width: 60, height: 60)
                            .foregroundColor(Color.white)
                            .padding(.all, 6)
                    })
                    .background {
                        Circle()
                            .fill(Color(.sRGB, red: 153/255, green: 15/255, blue: 238/255))
                    }
                    .shadow(color: Color.black.opacity(0.3),
                            radius: 3,
                            x: 3,
                            y: 3)
                }
                .padding(.all, 10)
            }
        }
    }
}
