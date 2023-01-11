//
//  AddNewUser_Button.swift
//  VRef_v1
//
//  Created by William on 04/01/2023.
//

import SwiftUI

struct AddNewUser_Button: View {
    
    @EnvironmentObject var adminPanelVM: AdminPanelViewModel
    
    var body: some View {
        Button(action: {
            
            adminPanelVM.createUser()
            adminPanelVM.showingNewUserForm = false
            
        }) {
            Text("Add new user")
                .font(.system(size: 25, weight: .medium, design: .default))
                .padding(.vertical, 15)
                .padding(.horizontal, 80)
        }
        .disabled(adminPanelVM.addUserDisabled)
        .foregroundColor(adminPanelVM.addUserDisabled ? Color(.systemGray4) : .white)
        .background {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(adminPanelVM.addUserDisabled ? .gray : Color(.sRGB, red: 153/255, green: 15/255, blue: 238/255))
                .frame(maxWidth: .infinity)
                .clipped()
        }
    }
}
