//
//  FullScreen_Button.swift
//  VRef_v1
//
//  Created by William on 09/11/2022.
//

import SwiftUI

struct FullScreen_Button: View {
    
    @Binding var fullScreen: Bool
    var player: Int
    
    var body: some View {
        Button(action: {
            fullScreen.toggle()
        }, label: {
            Image(systemName: fullScreen ? "arrow.down.right.and.arrow.up.left" : "arrow.up.left.and.arrow.down.right")
                .font(.system(.largeTitle))
                .frame(width: 70, height: 70)
                .foregroundColor(Color.white)
                .padding(.all, 6)
        })
        .shadow(color: Color.black.opacity(0.3),
                radius: 3,
                x: 3,
                y: 3)
    }
}
