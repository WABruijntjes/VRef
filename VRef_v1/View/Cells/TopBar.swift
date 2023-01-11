//
//  TopBar.swift
//  VRef_v1
//
//  Created by William on 26/10/2022.
//

import SwiftUI
import Combine

struct TopBar: View {
    
    @EnvironmentObject var userSettings: UserSettings
    @EnvironmentObject var loginVM: LoginViewModel
    @EnvironmentObject var trainingOverviewVM: TrainingOverviewViewModel
    @EnvironmentObject var trainingSessionVM: TrainingSessionViewModel
    @State private var showLogOutConfirmation: Bool = false
    
    var body: some View {
        //------- Start Top Banner -------
        HStack(spacing: 30) {
            Image("VRef_Logo")
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(alignment: .topTrailing)
                .clipped()
            if(trainingSessionVM.currentTraining != nil){
                HStack(spacing: 10){
                    VStack(alignment: .leading){
                        Text("Training")
                            .font(.system(size: 25))
                            .fixedSize()
                        Text(trainingSessionVM.currentTraining?.parsedDate ?? Date(), format: .dateTime.day().month().year())
                            .fixedSize()
                    }
                    VStack{
                        Spacer()
                        HStack(alignment: .bottom){
                            ForEach(trainingSessionVM.selectedStudents) {student in
                                Image(systemName: "person.fill")
                                    .imageScale(.large)
                                    .font(.system(size: 15))
                                Text(student.fullName)
                                    .fixedSize()
                            }
                        }.foregroundColor(Color(.sRGB, red: 10/255, green: 90/255, blue: 254/255))
                    }
                }
            }
            HStack(alignment: .top, spacing: 0) {
                Image(systemName: "person")
                    .imageScale(.large)
                    .font(.system(size: 35, weight: .regular, design: .default))
                VStack(alignment: .trailing) {
                    if let fullName = userSettings.loggedInUser?.fullName {
                        Text(fullName.capitalized)
                            .font(.system(size: 20, weight: .bold, design: .default))
                    } else {
                        Text("Full Name")
                            .fixedSize()
                    }
                    
                    if let organization = userSettings.loggedInUser?.organization.name {
                        Text(organization.capitalized)
                            .font(.system(size: 15, weight: .regular, design: .default))
                    } else {
                        Text("Organization")
                            .fixedSize()
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
            .clipped()
            .foregroundColor(Color(.sRGB, red: 10/255, green: 90/255, blue: 254/255))
            
            Button(action: {
                showLogOutConfirmation = true
            }) {
                Image(systemName: "rectangle.portrait.and.arrow.forward")
                    .imageScale(.large)
                    .font(.system(size: 30))
            }.confirmationDialog("", isPresented: $showLogOutConfirmation) {
                 Button("Log Out", role: .destructive) {
                     loginVM.logout()
                 }
            }.background(Color(.sRGB, red: 41/255, green: 44/255, blue: 49/255))
        }
        .frame(maxWidth: .infinity, maxHeight: 50, alignment: .top)
        .clipped()
        .padding(.all)
        .background {
            RoundedRectangle(cornerRadius: 0, style: .continuous)
                .fill(Color(.sRGB, red: 41/255, green: 44/255, blue: 49/255))
                .shadow(color: .black.opacity(1), radius: 8, x: 0, y: 0)
        }
        .zIndex(.infinity) //To show shadow on elements below
        //------- End Top Banner -------//
    }
}
