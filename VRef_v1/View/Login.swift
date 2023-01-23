//
//  Login.swift
//  VRef_v1
//
//  Created by William on 29/11/2022.
//

import SwiftUI

struct Login: View {
    @EnvironmentObject var loginVM: LoginViewModel
        
    var body: some View {
        HStack(spacing: 0) {
            VStack(spacing: 15) {
                Text("LOGIN")
                    .font(.system(size: 50, weight: .bold, design: .default))
                    .foregroundColor(Color(.sRGB, red: 153/255, green: 15/255, blue: 238/255))
                
                TextField("Username", text: $loginVM.credentials.email)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding(.vertical, 10)
                    .padding(EdgeInsets(top: 0, leading: 6, bottom: 0, trailing: 6))
                    .overlay(Rectangle()
                        .frame(height: 2)
                        .padding(.top, 40)
                        .padding(.horizontal, 5)
                        .foregroundColor(Color(.sRGB, red: 153/255, green: 15/255, blue: 238/255)))
                    .foregroundColor(.white)
                    .font(.title)
                    .frame(width: 375)
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding(5)
                    .background(
                        RoundedRectangle(cornerRadius: 4, style: .continuous)
                            .stroke(Color(.sRGB, red: 153/255, green: 15/255, blue: 238/255), lineWidth: 3)
                    ).padding(.all, 5)
                
                
                SecureField("Password", text: $loginVM.credentials.password)
                    .textContentType(.password)
                    .padding(.vertical, 10)
                    .padding(EdgeInsets(top: 0, leading: 6, bottom: 0, trailing: 6))
                    .overlay(Rectangle()
                        .frame(height: 2)
                        .padding(.top, 40)
                        .padding(.horizontal, 5)
                        .foregroundColor(Color(.sRGB, red: 153/255, green: 15/255, blue: 238/255)))
                    .foregroundColor(.white)
                    .font(.title)
                    .frame(width: 375)
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding(5)
                    .background(
                        RoundedRectangle(cornerRadius: 4, style: .continuous)
                            .stroke(Color(.sRGB, red: 153/255, green: 15/255, blue: 238/255), lineWidth: 3)
                    ).padding(.all, 5)
                
                Spacer()
                    .frame(height: 25)
                
                Login_Button()
                    .alert(isPresented: $loginVM.loginAlert) {
                         Alert(title: Text("Login Error"),
                               message: Text(loginVM.loginErrorDescription),
                         dismissButton: .default(Text("Okay"))
                      )
                    }.padding(.bottom, 15)
                
                Button(action: {
                    loginVM.showingActivateAccountForm = true
                }) {
                    Text("Tap here to activate your account")
                        .underline()
                        .foregroundColor(Color(.sRGB, red: 153/255, green: 15/255, blue: 238/255))
                }
                .alert(isPresented: $loginVM.activationSuccessAlert) {
                     Alert(title: Text("Activation successful"),
                           message: Text("You account has been activated successfully and you can now login with your credentials"),
                           dismissButton: .default(Text("Okay"))
                  )
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .clipped()
            .background {
                RoundedRectangle(cornerRadius: 4, style: .continuous)
                    .fill(Color(.sRGB, red: 23/255, green: 23/255, blue: 23/255))
            }
            
            ZStack {
                Image("VRef_Logo_shadow_v2")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
                if loginVM.loading{
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        .scaleEffect(2)
                        .offset(y: 75)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .clipped()
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 4, style: .continuous)
                    .fill(Color(.sRGB, red: 33/255, green: 33/255, blue: 33/255))
            }
            .frame(maxHeight: .infinity)
            .clipped()
        }
        .sheet(isPresented: $loginVM.showingActivateAccountForm){
            ActivateAccountScreen()
        }
    }
}
