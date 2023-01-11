//
//  DeleteUser_Button.swift
//  VRef_v1
//
//  Created by William on 06/01/2023.
//

import SwiftUI

struct DeleteUser_Button: View {
    @EnvironmentObject var adminPanelVM: AdminPanelViewModel
    @State var showingDeleteConfirmation: Bool = false
    
    var body: some View {
        Button(action: {
            
            showingDeleteConfirmation = true
            
        }) {
            Text("Delete user")
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
        .alert("Are you sure you want to delete this user?", isPresented: $showingDeleteConfirmation){
            Button("   Delete user   ", role: .destructive) {
                adminPanelVM.deleteUser()
                adminPanelVM.selectedUserID = nil
                adminPanelVM.showingChangeUserForm = false
             }
        }message: {
            Text("\n CAUTION! This can not be undone! \n The references to this user will be removed from all training session they have taken part in.")
        }
    }
}
