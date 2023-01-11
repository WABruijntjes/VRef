//
//  NewUserScreen.swift
//  VRef_v1
//
//  Created by William on 03/01/2023.
//

import SwiftUI

struct NewUserScreen: View {
    
    @EnvironmentObject var adminPanelVM: AdminPanelViewModel
    
    var body: some View {
        VStack{
            HStack {
                Text("New User")
                    .font(.largeTitle.weight(.bold))
                Spacer()
                Image(systemName: "xmark")
                    .imageScale(.large)
                    .font(.largeTitle)
                    .onTapGesture {
                        adminPanelVM.showingNewUserForm = false
                    }
            }
            .ignoresSafeArea(.keyboard)
            .padding()
            
            HStack(spacing: 30){
                Text("Firstname")
                Spacer()
                Text("Lastname")
                Spacer()
            }
            .foregroundColor(Color(.sRGB, red: 132/255, green: 132/255, blue: 132/255))
            HStack{
                ZStack{
                    TextField("Ex. Peter",text: $adminPanelVM.newUserFirstName)
                        .textContentType(.name)
                        .keyboardType(.default)
                        .autocapitalization(.words)
                        .padding(.all)
                        .background(Color(.sRGB, red: 33/255, green: 33/255, blue: 33/255))
                    Divider()
                        .padding(.horizontal, 25)
                        .frame(width: 300, height: 2)
                        .overlay(Color(.sRGB, red: 169/255, green: 0/255, blue: 247/255))
                        .offset(y: 15)
                }
                .background(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(Color(.sRGB, red: 33/255, green: 33/255, blue: 33/255))
                        .frame(height: 60)
                )
                
                ZStack{
                    TextField("Ex. Parker",text: $adminPanelVM.newUserLastName)
                        .textContentType(.familyName)
                        .keyboardType(.default)
                        .autocapitalization(.words)
                        .padding(.all)
                        .background(Color(.sRGB, red: 33/255, green: 33/255, blue: 33/255))
                    Divider()
                        .padding(.horizontal, 25)
                        .frame(width: 300, height: 2)
                        .overlay(Color(.sRGB, red: 169/255, green: 0/255, blue: 247/255))
                        .offset(y: 15)
                }
                .background(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(Color(.sRGB, red: 33/255, green: 33/255, blue: 33/255))
                        .frame(height: 60)
                )
            }.padding(.bottom, 10)
            HStack(spacing: 30){
                Text("E-Mail")
                Spacer()
                    .frame(width: 420)
                Text("User Type")
                Spacer()
            }
            .foregroundColor(Color(.sRGB, red: 132/255, green: 132/255, blue: 132/255))
            HStack{
                ZStack{
                    TextField(String("Ex. PeterParker@Email.com"),text: $adminPanelVM.newUserEmail)
                        .textContentType(.emailAddress)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.words)
                        .padding(.all)
                        .background(Color(.sRGB, red: 33/255, green: 33/255, blue: 33/255))
                    Divider()
                        .padding(.horizontal, 25)
                        .frame(width: 500, height: 2)
                        .overlay(Color(.sRGB, red: 169/255, green: 0/255, blue: 247/255))
                        .offset(y: 15)
                }
                .background(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(Color(.sRGB, red: 33/255, green: 33/255, blue: 33/255))
                        .frame(height: 60)
                )
                Picker("", selection: $adminPanelVM.newUserType) {
                    ForEach(UserType.allCases, id: \.self) { value in
                        if(value != UserType.SuperAdmin){
                            Text(value.rawValue)
                        }
                    }
                }
                .accentColor(.white)
                .pickerStyle(.menu)
                .frame(width: 150)
                .background(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(Color(.sRGB, red: 33/255, green: 33/255, blue: 33/255))
                        .frame(height: 60)
                )
            }
            Spacer()
            VStack(spacing: 15){
                AddNewUser_Button()
                Cancel_Button()
            }
        }.padding(.all)
    }
}
