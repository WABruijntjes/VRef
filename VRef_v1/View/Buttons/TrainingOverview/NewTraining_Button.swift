//
//  NewTraining_Button.swift
//  VRef_v1
//
//  Created by William on 03/01/2023.
//

import SwiftUI

struct NewTraining_Button: View {
    
    @State private var navigateToNewTrainingScreen : Bool = false
    
    var body: some View {
        Button(action: {
            navigateToNewTrainingScreen = true
        }){
            Text("New Training")
                .padding(.all, 15)
                .font(.system(size: 25, weight: .bold, design: .default))
                .multilineTextAlignment(.leading)
            Image(systemName: "plus")
                .imageScale(.large)
                .padding(.all, 10)
                .font(.system(size: 17, weight: .regular, design: .default))
        }
        .navigationDestination(isPresented: $navigateToNewTrainingScreen) {
            NewTrainingScreen()
        }
        .foregroundColor(.white)
        .background {
            Capsule(style: .continuous)
                .fill(Color(.sRGB, red: 153/255, green: 15/255, blue: 238/255))
        }
    }
}
