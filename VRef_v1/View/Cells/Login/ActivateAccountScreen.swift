//
//  ActivateAccountScreen.swift
//  VRef_v1
//
//  Created by William on 09/01/2023.
//

import SwiftUI

struct ActivateAccountScreen: View {
    
    @EnvironmentObject var loginVM: LoginViewModel
    
    var body: some View {
        VStack(spacing: 25){
            HStack {
                Text("Activate account")
                    .font(.largeTitle.weight(.bold))
                Spacer()
                Image(systemName: "xmark")
                    .imageScale(.large)
                    .font(.largeTitle)
                    .onTapGesture {
                        loginVM.showingActivateAccountForm = false
                    }
            }
            .ignoresSafeArea(.keyboard)
            .padding()
            
            Text("Activation Code")
                .foregroundColor(Color(.sRGB, red: 132/255, green: 132/255, blue: 132/255))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 50)
            ZStack{
                TextField("",text: $loginVM.activationCode)
                    .textContentType(.oneTimeCode)
                    .keyboardType(.default)
                    .autocapitalization(.words)
                    .padding(.all)
                    .background(Color(.sRGB, red: 33/255, green: 33/255, blue: 33/255))
                Divider()
                    .padding(.horizontal, 25)
                    .frame(width: 550, height: 2)
                    .overlay(Color(.sRGB, red: 169/255, green: 0/255, blue: 247/255))
                    .offset(y: 15)
            }
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color(.sRGB, red: 33/255, green: 33/255, blue: 33/255))
                    .frame(height: 60)
            )
            .padding(.horizontal, 50)
            
            Text("Your new password")
                .foregroundColor(Color(.sRGB, red: 132/255, green: 132/255, blue: 132/255))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 50)
            ZStack{
                SecureField("",text: $loginVM.newPassword)
                    .textContentType(.newPassword)
                    .keyboardType(.default)
                    .autocapitalization(.words)
                    .padding(.all)
                    .background(Color(.sRGB, red: 33/255, green: 33/255, blue: 33/255))
                Divider()
                    .padding(.horizontal, 25)
                    .frame(width: 550, height: 2)
                    .overlay(Color(.sRGB, red: 169/255, green: 0/255, blue: 247/255))
                    .offset(y: 15)
            }
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color(.sRGB, red: 33/255, green: 33/255, blue: 33/255))
                    .frame(height: 60)
            )
            .padding(.horizontal, 50)
            
            Text("Confirm password")
                .foregroundColor(Color(.sRGB, red: 132/255, green: 132/255, blue: 132/255))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 50)
            ZStack{
                SecureField("",text: $loginVM.confirmPassword)
                    .textContentType(.newPassword)
                    .keyboardType(.default)
                    .autocapitalization(.words)
                    .padding(.all)
                    .background(Color(.sRGB, red: 33/255, green: 33/255, blue: 33/255))
                Divider()
                    .padding(.horizontal, 25)
                    .frame(width: 550, height: 2)
                    .overlay(Color(.sRGB, red: 169/255, green: 0/255, blue: 247/255))
                    .offset(y: 15)
            }
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color(.sRGB, red: 33/255, green: 33/255, blue: 33/255))
                    .frame(height: 60)
            )
            .padding(.horizontal, 50)
            
            Spacer()
            HStack{
                Cancel_Button()
                Spacer()
                Activate_Button()
            }.padding(10)
        }
        .padding()
    }
}
