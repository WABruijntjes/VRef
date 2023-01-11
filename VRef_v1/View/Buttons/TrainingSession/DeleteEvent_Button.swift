//
//  DeleteEvent_Button.swift
//  VRef_v1
//
//  Created by William on 09/01/2023.
//

import SwiftUI

struct DeleteEvent_Button: View {
    
    @EnvironmentObject var trainingSessionVM: TrainingSessionViewModel
    var eventToDelete: Event
    
    @State var showingDeleteConfirmation: Bool = false
    
    var body: some View {
        Button(action: {
            
            showingDeleteConfirmation = true
            
        }) {
            Text("Delete event")
                .font(.system(size: 25, weight: .medium, design: .default))
                .foregroundColor(.white)
                .padding(.vertical, 5)
                .padding(.horizontal, 80)
        }
        .background {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color(.sRGB, red: 253/255, green: 77/255, blue: 77/255))
                .frame(maxWidth: .infinity)
                .clipped()
        }
        .alert("Are you sure you want to delete this event?", isPresented: $showingDeleteConfirmation){
            Button("   Delete event   ", role: .destructive) {
                trainingSessionVM.deleteEvent(eventToDelete: eventToDelete)
                trainingSessionVM.showingChangeEventForm = false
             }
        }message: {
            Text("\n This can not be undone!")
        }
    }
}
