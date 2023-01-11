//
//  Back_Button.swift
//  VRef_v1
//
//  Created by William on 05/01/2023.
//

import SwiftUI

struct Back_Button: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack{
                Image(systemName: "chevron.left")
                Text("Back")
            }.font(.system(size: 18, weight: .regular, design: .default))
                .foregroundColor(Color(.sRGB, red: 0/255, green: 130/255, blue: 254/255))
        }
    }
}
