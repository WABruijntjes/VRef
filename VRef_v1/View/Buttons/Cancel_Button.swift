//
//  Cancel_Button.swift
//  VRef_v1
//
//  Created by William on 05/11/2022.
//

import SwiftUI

struct Cancel_Button: View {

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Text("Cancel")
                .font(.system(size: 25, weight: .medium, design: .default))
                .foregroundColor(Color(.sRGB, red: 153/255, green: 15/255, blue: 238/255))
                .padding(.vertical, 5)
                .padding(.horizontal, 80)
        }
        .background {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color(.sRGB, red: 221/255, green: 221/255, blue: 221/255))
                .frame(maxWidth: .infinity)
                .clipped()
        }
    }
}
