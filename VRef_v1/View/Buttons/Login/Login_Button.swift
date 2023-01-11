//
//  Login_Button.swift
//  VRef_v1
//
//  Created by William on 09/01/2023.
//

import SwiftUI

struct Login_Button: View {
    
    @EnvironmentObject var loginVM: LoginViewModel
    
    var body: some View {
        Button(action: {
            loginVM.login()
        }) {
            Text("Login".uppercased())
                .font(.system(size: 30, weight: .medium, design: .default))
                .padding()
        }
        .disabled(loginVM.loginDisabled)
        .foregroundColor(loginVM.loginDisabled ? Color(.systemGray4) : .white)
        .background {
            RoundedRectangle(cornerRadius: 4, style: .continuous)
                .fill(loginVM.loginDisabled ? .gray : Color(.sRGB, red: 153/255, green: 15/255, blue: 238/255))
                .frame(width: 350, height: 50)
                .clipped()
        }
    }
}
