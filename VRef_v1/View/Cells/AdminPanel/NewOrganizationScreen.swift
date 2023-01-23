//
//  NewOrganizationScreen.swift
//  VRef_v1
//
//  Created by William on 06/01/2023.
//

import SwiftUI

struct NewOrganizationScreen: View {
    
    @EnvironmentObject var adminPanelVM: AdminPanelViewModel
    
    @State var nameCharacterLimit: Int = 50
    
    var body: some View {
        VStack{
            HStack {
                Text("New Organization")
                    .font(.largeTitle.weight(.bold))
                Spacer()
                Image(systemName: "xmark")
                    .imageScale(.large)
                    .font(.largeTitle)
                    .onTapGesture {
                        adminPanelVM.showingNewOrganizationForm = false
                    }
            }
            .ignoresSafeArea(.keyboard)
            .padding()
            .padding(.bottom, 20)

            Text("Organization name")
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundColor(Color(.sRGB, red: 132/255, green: 132/255, blue: 132/255))
            
            ZStack{
                TextField(String("Ex. Pilot Inc."),text: $adminPanelVM.newOrganizationName)
                    .onChange(of: adminPanelVM.newOrganizationName) { nameValue in
                        if nameValue.count > self.nameCharacterLimit {
                            adminPanelVM.newOrganizationName = String(nameValue.prefix(self.nameCharacterLimit))
                        }
                    }
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.words)
                    .padding(.all)
                    .background(Color(.sRGB, red: 33/255, green: 33/255, blue: 33/255))
                Divider()
                    .padding(.horizontal, 25)
                    .frame(width: 650, height: 2)
                    .overlay(Color(.sRGB, red: 169/255, green: 0/255, blue: 247/255))
                    .offset(y: 15)
            }
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color(.sRGB, red: 33/255, green: 33/255, blue: 33/255))
                    .frame(height: 60)
            )
            Spacer()
            VStack(spacing: 15){
                AddNewOrganization_Button()
                Cancel_Button()
            }
        }.padding(.all)
    }
}
