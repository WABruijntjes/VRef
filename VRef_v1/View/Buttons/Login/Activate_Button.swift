//
//  Activate_Button.swift
//  VRef_v1
//
//  Created by William on 09/01/2023.
//

import SwiftUI

struct Activate_Button: View {
    
    @EnvironmentObject var loginVM: LoginViewModel
    
    var body: some View {
        Button(action: {
            
            loginVM.activateAccount()
            loginVM.showingActivateAccountForm = false
            
        }) {
            Text("Activate")
                .font(.system(size: 25, weight: .medium, design: .default))
                .padding(.vertical, 5)
                .padding(.horizontal, 80)
        }
        .disabled(loginVM.activateDisabled)
        .foregroundColor(loginVM.activateDisabled ? Color(.systemGray4) : .white)
        .background {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(loginVM.activateDisabled ? .gray : Color(.sRGB, red: 153/255, green: 15/255, blue: 238/255))
                .frame(maxWidth: .infinity)
                .clipped()
        }
    }
}
