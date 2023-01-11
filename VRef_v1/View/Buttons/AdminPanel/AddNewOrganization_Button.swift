//
//  AddNewOrganization_Button.swift
//  VRef_v1
//
//  Created by William on 06/01/2023.
//

import SwiftUI

struct AddNewOrganization_Button: View {
    @EnvironmentObject var adminPanelVM: AdminPanelViewModel
    
    var body: some View {
        Button(action: {
            
            adminPanelVM.createOrganization()
            adminPanelVM.showingNewOrganizationForm = false
            
        }) {
            Text("Add new organization")
                .font(.system(size: 25, weight: .medium, design: .default))
                .padding(.vertical, 15)
                .padding(.horizontal, 50)
        }
        .disabled(adminPanelVM.addOrganizationDisabled )
        .foregroundColor(adminPanelVM.addOrganizationDisabled ? Color(.systemGray4) : .white)
        .background {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(adminPanelVM.addOrganizationDisabled ? .gray : Color(.sRGB, red: 153/255, green: 15/255, blue: 238/255))
                .frame(maxWidth: .infinity)
                .clipped()
        }
    }
}
