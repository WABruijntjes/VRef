//
//  DeleteOrganization_Button.swift
//  VRef_v1
//
//  Created by William on 09/01/2023.
//

import SwiftUI

struct DeleteOrganization_Button: View {
    @EnvironmentObject var adminPanelVM: AdminPanelViewModel
    @State var showingDeleteConfirmation: Bool = false
    @State var showingDeleteDialogue: Bool = false
    
    var body: some View {
        Button(action: {
            withAnimation {
                
                showingDeleteDialogue = true
                
            }
        }, label: {
            Image(systemName: "trash.fill")
                .font(.system(size: 20, weight: .regular, design: .default))
                .frame(width: 30, height: 30)
                .foregroundColor(Color.white)
                .padding(.all, 6)
        })
        .background {
            Circle()
                .fill(Color(.sRGB, red: 253/255, green: 77/255, blue: 77/255))
        }
        .confirmationDialog("", isPresented: $showingDeleteDialogue) {
            Button("Delete \(adminPanelVM.currentOrganization?.name ?? "this organization")", role: .destructive) {
                showingDeleteConfirmation = true
             }
        }.alert("Are you sure you want to delete this organization?", isPresented: $showingDeleteConfirmation){
            Button("   Delete organization   ", role: .destructive) {
                adminPanelVM.deleteOrganization()
                adminPanelVM.showingChangeOrganizationBox = false
             }
        }message: {
            Text("\n CAUTION! This can not be undone! \n Deleting this organization will also delete all of its users and their personal information. The references to this organization's users will be removed from all training sessions they have taken part in.")
        }
    }
}
