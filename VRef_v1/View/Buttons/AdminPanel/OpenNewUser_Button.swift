//
//  NewUser_Button.swift
//  VRef_v1
//
//  Created by William on 03/01/2023.
//

import SwiftUI

struct OpenNewUser_Button: View {
    
    @EnvironmentObject var adminPanelVM: AdminPanelViewModel
    
    var body: some View {
        Button(action: {
            adminPanelVM.showingNewUserForm = true
        }, label: {
            Text("New User")
                .padding(.all, 15)
                .font(.system(size: 25, weight: .bold, design: .default))
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
