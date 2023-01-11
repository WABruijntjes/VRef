//
//  OrganizationCell.swift
//  VRef_v1
//
//  Created by William on 04/01/2023.
//

import SwiftUI

struct OrganizationCell: View {
    
    @EnvironmentObject var adminPanelVM: AdminPanelViewModel
    var organization: Organization
    
    var body: some View {
        HStack{
            Text(organization.name)
                .foregroundColor(adminPanelVM.currentOrganization?.id == organization.id ? Color(.sRGB, red: 153/255, green: 15/255, blue: 238/255) : .white)
                .font(.system(size: 20, weight: adminPanelVM.currentOrganization?.id == organization.id ? .semibold : .regular, design: .default))
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: 50, alignment: .top)
        .padding(.all)
        .background {
            RoundedRectangle(cornerRadius: 0, style: .continuous)
                .fill(Color(.sRGB, red: 41/255, green: 44/255, blue: 49/255))
                .shadow(color: .black.opacity(1), radius: 5, x: 0, y: 5)
        }
        .onTapGesture {
            adminPanelVM.currentOrganization = organization
            adminPanelVM.getAllUsers()
            adminPanelVM.selectedUserID = nil
            adminPanelVM.showingChangeOrganizationBox = false
        }
    }
}
