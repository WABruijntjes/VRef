//
//  ChangeUser_Button.swift
//  VRef_v1
//
//  Created by William on 05/01/2023.
//

import SwiftUI

struct ChangeUser_Button: View {
    
    @EnvironmentObject var adminPanelVM: AdminPanelViewModel
    var userToChange: User
    
    var changeUserDisabled: Bool{
        userToChange.firstName.isEmpty || userToChange.lastName.isEmpty || userToChange.email.isEmpty
    }
    
    
    var body: some View {
        Button(action: {
            
            adminPanelVM.changeUser(userToChange: userToChange)
            adminPanelVM.showingChangeUserForm = false
            
        }) {
            Text("Save changes")
                .font(.system(size: 25, weight: .medium, design: .default))
                .padding(.vertical, 15)
                .padding(.horizontal, 80)
        }
        .disabled(changeUserDisabled)
        .foregroundColor(changeUserDisabled ? Color(.systemGray4) : .white)
        .background {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(changeUserDisabled ? .gray : Color(.sRGB, red: 153/255, green: 15/255, blue: 238/255))
                .frame(maxWidth: .infinity)
                .clipped()
        }
    }
}
