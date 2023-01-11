//
//  AdminPanel.swift
//  VRef_v1
//
//  Created by William on 03/01/2023.
//

import SwiftUI

struct AdminPanel: View {
    
    @EnvironmentObject var userSettings: UserSettings
    @EnvironmentObject var adminPanelVM: AdminPanelViewModel
    
    var body: some View {
        ZStack{
            HStack{
                if(userSettings.loggedInUser?.userType == .SuperAdmin){
                    if(adminPanelVM.showingOrganizationList){
                        OrganizationList()
                            .transition(.move(edge: .leading))
                    }
                    VStack{
                        ZStack{
                            Image(systemName: adminPanelVM.showingOrganizationList ? "rectangle.lefthalf.filled" : "sidebar.left")
                                .foregroundColor(adminPanelVM.showingOrganizationList ? Color(.sRGB, red: 41/255, green: 41/255, blue: 41/255) : Color(.sRGB, red: 132/255, green: 132/255, blue: 132/255))
                                .font(.system(size: 30, weight: .regular, design: .default))
                            Image(systemName: adminPanelVM.showingOrganizationList ? "arrow.left" : "hand.tap.fill")
                                .offset(x: adminPanelVM.showingOrganizationList ?  0 : 10, y: adminPanelVM.showingOrganizationList ?  0 : 5)
                                .foregroundColor(.white)
                                .font(.system(size: 20, weight: .regular, design: .default))
                            
                        }
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                adminPanelVM.showingOrganizationList.toggle()
                            }
                        }
                        .offset(x: adminPanelVM.showingOrganizationList ? -30 : 0, y: 5)
                        Spacer()
                    }
                }
                
                VStack(alignment: .leading) {
                    HStack {
                        if(adminPanelVM.showingChangeOrganizationBox){
                            TextField("Ex. Pilot Inc.",text: $adminPanelVM.organizationNameToChange)
                                .textContentType(.organizationName)
                                .keyboardType(.default)
                                .autocapitalization(.words)
                                .padding(.all)
                                .background(Color(.sRGB, red: 33/255, green: 33/255, blue: 33/255))
                                .font(.largeTitle.weight(.bold))
                            Button(action: {
                                adminPanelVM.changeOrganization()
                                adminPanelVM.currentOrganization?.name = adminPanelVM.organizationNameToChange
                                adminPanelVM.showingChangeOrganizationBox = false
                            }){
                                Image(systemName: "checkmark")
                                    .imageScale(.large)
                                    .padding(.all, 10)
                                    .font(.system(size: 17, weight: .regular, design: .default))
                            }
                            .disabled(adminPanelVM.editOrganizationDisabled)
                            .foregroundColor(adminPanelVM.editOrganizationDisabled ? Color(.systemGray4) : Color(.sRGB, red: 0/255, green: 131/255, blue: 254/255))
                            
                            Button(action: {
                                adminPanelVM.showingChangeOrganizationBox = false
                            }){
                                Image(systemName: "xmark")
                                    .imageScale(.large)
                                    .padding(.all, 10)
                                    .font(.system(size: 17, weight: .regular, design: .default))
                            }
                        }else{
                            Text(adminPanelVM.currentOrganization?.name ?? "Organization")
                                .font(.largeTitle.weight(.bold))
                                .onTapGesture(count: 2) {
                                    guard let organizationName = adminPanelVM.currentOrganization?.name else{
                                        print("No organization name to change")
                                        return
                                    }
                                    adminPanelVM.organizationNameToChange = organizationName
                                    adminPanelVM.showingChangeOrganizationBox = true
                                }
                            Image(systemName: "pencil")
                                .imageScale(.large)
                                .foregroundColor(Color(.sRGB, red: 153/255, green: 15/255, blue: 238/255))
                                .font(.system(size: 20, weight: .regular, design: .default))
                                .padding()
                                .onTapGesture {
                                    guard let organizationName = adminPanelVM.currentOrganization?.name else{
                                        print("No organization name to change")
                                        return
                                    }
                                    adminPanelVM.organizationNameToChange = organizationName
                                    adminPanelVM.showingChangeOrganizationBox = true
                                }
                        }
                        Spacer()
                    }
                    .padding(.top, 50)
                    .padding(.horizontal)
                    Text("Users")
                        .padding(.horizontal, 15)
                        .underline()
                        .font(.title)
                    VStack{
                        if(adminPanelVM.loadingUsers){
                            ZStack(alignment: .center){
                                Spacer()
                                ProgressView("Loading users from \(adminPanelVM.currentOrganization?.name ?? "this organization")").progressViewStyle(CircularProgressViewStyle(tint: .blue))
                            }.frame(maxWidth: .infinity)
                            Spacer().frame(maxHeight: .infinity)
                        }else{
                            if(adminPanelVM.userList.isEmpty == false){
                                Table(adminPanelVM.userList, selection: $adminPanelVM.selectedUserID) {
                                    TableColumn("Full name", value: \.fullName).width(250)
                                    TableColumn("E-Mail", value: \.email).width(400)
                                    TableColumn("User Type", value: \.userType.rawValue)
                                }
                                .scrollContentBackground(.hidden)
                                .cornerRadius(4, corners: [.bottomRight, .bottomLeft, .topRight, .topLeft])
                                .refreshable {
                                    adminPanelVM.getAllUsers()
                                }
                            }else{
                                ScrollView{
                                    Text("There are no users in \(adminPanelVM.currentOrganization?.name ?? "this organization")").foregroundColor(.gray).padding(.horizontal, 15)
                                    Spacer().frame(maxHeight: .infinity)
                                }.refreshable {
                                    adminPanelVM.getAllUsers()
                                }
                            }
                        }
                    }
                    HStack(spacing: 20){
                        Spacer()
                        OpenChangeUser_Button()
                        OpenNewUser_Button()
                    }.padding(.horizontal)
                    Spacer()
                }
                .padding(.vertical)
                .onAppear{
                    adminPanelVM.getAllUsers()
                }
                .sheet(isPresented: $adminPanelVM.showingNewUserForm){
                    NewUserScreen()
                }
                .sheet(isPresented: $adminPanelVM.showingChangeUserForm){
                    ChangeUserScreen(userToChange: adminPanelVM.selectedUser!)
                }
                .sheet(isPresented: $adminPanelVM.showingNewOrganizationForm){
                    NewOrganizationScreen()
                }
                .alert(isPresented: $adminPanelVM.adminAlert) {
                    Alert(title: Text("Error"),
                          message: Text(adminPanelVM.adminErrorDescription),
                          dismissButton: .default(Text("Okay"))
                    )
                }
            }
            .background(
                RoundedRectangle(cornerRadius: 4, style: .continuous)
                    .fill(Color(.sRGB, red: 23/255, green: 23/255, blue: 23/255))
            )
            .onAppear{
                adminPanelVM.currentOrganization = userSettings.loggedInUser?.organization
            }
            .ignoresSafeArea(.keyboard)
            .toolbar(.hidden)
            
            if(userSettings.loggedInUser?.userType == .SuperAdmin){
                VStack{
                    HStack{
                        Spacer()
                        DeleteOrganization_Button()
                            .padding()
                    }
                    Spacer()
                }
            }
        }
    }
}
