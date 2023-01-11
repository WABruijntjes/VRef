//
//  Greeting_NewTraining.swift
//  VRef_v1
//
//  Created by William on 26/10/2022.
//

import SwiftUI

struct Greeting_NewTraining: View {
    
    @EnvironmentObject var userSettings: UserSettings
    @State var date: Date = Date()
    
    var body: some View {
        //------ Start Greeting & Training ------//
        ZStack{
//            if(userSettings.loggedInUser?.userType == UserType.Admin || userSettings.loggedInUser?.userType == UserType.SuperAdmin){
//                VStack{
//                    HStack{
//                        Spacer()
//                        AdminPanel_Button()
//                    }
//                    .padding(.horizontal, 30)
//                    .padding(.vertical, 15)
//                    Spacer()
//                }
//            }
            VStack {
                Spacer()
                    .frame(height: 100)
                    .clipped()
                if let fullName = userSettings.loggedInUser?.fullName {
                    Text("Hello \n\(fullName)".uppercased())
                        .font(.largeTitle.weight(.semibold))
                        .foregroundColor(Color(.sRGB, red: 153/255, green: 15/255, blue: 238/255))
                        .multilineTextAlignment(.center)
                } else {
                    ProgressView()
                }
                
                Spacer()
                HStack {
                    Spacer()
                    if(userSettings.loggedInUser?.userType != UserType.Student){
                        NewTraining_Button()
                    }
                }
            }
            .padding(20)
        }
    }
    //------ End Greeting & Training ------//
}
