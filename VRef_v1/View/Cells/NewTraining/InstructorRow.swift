//
//  InstructorRow.swift
//  VRef_v1
//
//  Created by William on 03/11/2022.
//

import SwiftUI

struct InstructorRow: View {
    
    @EnvironmentObject var userSettings: UserSettings
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                if let fullName = userSettings.loggedInUser?.fullName {
                    Text(fullName.capitalized)
                } else {
                    Text("Full Name")
                }
                if let email = userSettings.loggedInUser?.email {
                    Text(email)
                        .underline()

                } else {
                    Text("Email")
                }
                    
            }
            .padding()
            Spacer()
            VStack {
                Image(systemName: "person")
                    .font(.system(size: 30, weight: .regular, design: .default))
                Text("Instructor")
            }
            .padding()
        }
        .frame(maxWidth: .infinity)
        .clipped()
    }
}
