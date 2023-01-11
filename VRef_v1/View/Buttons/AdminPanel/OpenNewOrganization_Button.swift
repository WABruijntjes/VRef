//
//  OpenNewOrganization_Button.swift
//  VRef_v1
//
//  Created by William on 05/01/2023.
//

import SwiftUI

struct OpenNewOrganization_Button: View {
    
    @EnvironmentObject var adminPanelVM: AdminPanelViewModel
    
    var body: some View {
        Button(action: {
            adminPanelVM.showingNewOrganizationForm = true
        }, label: {
            Text("New Organization")
                .padding(.vertical, 15)
                .padding(.leading, 15)
                .font(.system(size: 20, weight: .bold, design: .default))
                .multilineTextAlignment(.leading)
            Image(systemName: "plus")
                .imageScale(.large)
                .padding(.all, 10)
                .font(.system(size: 17, weight: .regular, design: .default))
        })
        .foregroundColor(.white)
        .background {
            Capsule(style: .continuous)
                .fill(Color(.sRGB, red: 153/255, green: 15/255, blue: 238/255))
        }
    }
}
