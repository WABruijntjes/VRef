//
//  AddEvent_Button.swift
//  VRef_v1
//
//  Created by William on 24/12/2022.
//

import SwiftUI

struct AddEvent_Button: View {
    
    @EnvironmentObject var trainingSessionVM: TrainingSessionViewModel
    
    var body: some View {
        Button(action: {
            trainingSessionVM.createFeedbackEvent()
            trainingSessionVM.showingAddEventForm = false
        }) {
            Text("Add Event")
                .font(.system(size: 25, weight: .medium, design: .default))
                .padding(.vertical, 5)
                .padding(.horizontal, 60)
        }
        .disabled(trainingSessionVM.addEventDisabled )
        .foregroundColor(trainingSessionVM.addEventDisabled ? Color(.systemGray4) : .white)
        .background {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(trainingSessionVM.addEventDisabled ? .gray : Color(.sRGB, red: 153/255, green: 15/255, blue: 238/255))
                .frame(maxWidth: .infinity)
                .clipped()
        }
    }
}
