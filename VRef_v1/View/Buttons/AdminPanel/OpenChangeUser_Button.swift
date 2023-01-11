//
//  EditUser_Button.swift
//  VRef_v1
//
//  Created by William on 03/01/2023.
//

import SwiftUI

struct OpenChangeUser_Button: View {
    
    @EnvironmentObject var adminPanelVM: AdminPanelViewModel
    
    var body: some View {
        Button(action: {
            
            adminPanelVM.showingChangeUserForm = true
            
        }, label: {
            Text("Edit User")
                .padding(.all, 15)
                .font(.system(size: 25, weight: .bold, design: .default))
                .multilineTextAlignment(.leading)
            Image(systemName: "pencil")
                .imageScale(.large)
                .padding(.all, 10)
                .font(.system(size: 17, weight: .regular, design: .default))
        })
        .disabled(adminPanelVM.editUserDisabled)
        .foregroundColor(adminPanelVM.editUserDisabled ? Color(.systemGray4) : .white)
        .background {
            Capsule(style: .continuous)
                .fill(adminPanelVM.editUserDisabled ? .gray : Color(.sRGB, red: 153/255, green: 15/255, blue: 238/255))
        }
    }
}
