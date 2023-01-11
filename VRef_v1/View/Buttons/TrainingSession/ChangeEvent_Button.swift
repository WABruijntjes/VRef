//
//  ChangeEvent_Button.swift
//  VRef_v1
//
//  Created by William on 02/01/2023.
//

import Foundation
import SwiftUI

struct ChangeEvent_Button: View {
    
    @EnvironmentObject var trainingSessionVM: TrainingSessionViewModel
    var eventToChange: Event
    
    var changeEventDisabled: Bool{
        eventToChange.name.isEmpty || eventToChange.message.isEmpty
    }
    
    var body: some View {
        Button(action: {
            trainingSessionVM.changeEvent(eventToChange: eventToChange)
            trainingSessionVM.showingChangeEventForm = false
        }) {
            Text("Save changes")
                .font(.system(size: 25, weight: .medium, design: .default))
                .padding(.vertical, 5)
                .padding(.horizontal, 60)
        }
        .disabled(changeEventDisabled)
        .foregroundColor(changeEventDisabled ? Color(.systemGray4) : .white)
        .background {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(changeEventDisabled ? .gray : Color(.sRGB, red: 153/255, green: 15/255, blue: 238/255))
                .frame(maxWidth: .infinity)
                .clipped()
        }
    }
}
