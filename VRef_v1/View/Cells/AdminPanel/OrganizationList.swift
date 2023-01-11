//
//  OrganizationList.swift
//  VRef_v1
//
//  Created by William on 04/01/2023.
//

import SwiftUI

struct OrganizationList: View {
    
    @EnvironmentObject var adminPanelVM: AdminPanelViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
//            HStack{
//                Back_Button()
//                Spacer()
//            }.padding()
            Text("Organizations")
                .padding()
                .font(.title)
            Divider()
                .padding(.bottom, 5)
            ScrollView{
                if(adminPanelVM.loadingOrganizations){
                    VStack(alignment: .center){
                        ProgressView("Loading organizations").progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    }.frame(maxWidth: .infinity)
                }else{
                    LazyVStack(spacing: 3) {
                        if (adminPanelVM.organizationList.isEmpty == false) {
                            ForEach(adminPanelVM.organizationList) { organization in
                                OrganizationCell(organization: organization)
                            }
                        }else{
                            Spacer()
                            Text("No organizations found. Try refreshing by pulling this text down").foregroundColor(.gray).padding()
                        }
                    }
                }
            }
            .refreshable {
                adminPanelVM.getAllOrganizations()
            }
            HStack{
                Spacer()
                OpenNewOrganization_Button()
            }.padding()
        }
        .background(
            Rectangle()
                .fill(Color(.sRGB, red: 41/255, green: 41/255, blue: 41/255))
                .cornerRadius(10, corners: [.bottomRight, .topRight])
        )
        .frame(maxWidth: 300)
        .onAppear{
            if(adminPanelVM.organizationList.isEmpty){
                adminPanelVM.getAllOrganizations()
            }
        }
    }
}
