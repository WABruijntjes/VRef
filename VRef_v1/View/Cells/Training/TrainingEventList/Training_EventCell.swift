//
//  Training_EventCell.swift
//  VRef_v1
//
//  Created by William on 06/11/2022.
//

import SwiftUI

struct Training_EventCell: View {
    @EnvironmentObject var trainingSessionVM: TrainingSessionViewModel

    @Binding var eventToChange: Event?

    var event: Event
    
    var body: some View {
        HStack(spacing: 5) {
            Button(action: {
                eventToChange = event
                trainingSessionVM.showingChangeEventForm = true
            }, label: {
                Text("Edit")
                    .font(.system(size: 15, weight: .regular, design: .default))
                    .foregroundColor(Color.white)
                    .padding(.horizontal, 25)
                    .padding(.vertical, 10)
            })
            .background {
                Capsule(style: .continuous)
                    .foregroundColor(Color(.sRGB, red: 153/255, green: 15/255, blue: 238/255))
                    .clipped()
            }
            Text(event.timeStamp.timeHoursMinutes)
                .font(.system(size: 25, weight: .regular, design: .default))
                .padding(.horizontal)
            
            if UIImage(systemName: VRef_Symbols.symbols[event.symbol] ?? "questionmark.circle.fill") == nil {
                Image(VRef_Symbols.symbols[event.symbol] ?? "questionmark.circle.fill")
                    .foregroundColor(VRef_Symbols.symbolColor(symbol: event.symbol))
                    .imageScale(.large)
                    .font(.system(size: 25, weight: .regular, design: .default))
            } else {
                Image(systemName: VRef_Symbols.symbols[event.symbol] ?? "questionmark.circle.fill")
                    .foregroundColor(VRef_Symbols.symbolColor(symbol: event.symbol))
                    .imageScale(.large)
                    .font(.system(size: 25, weight: .regular, design: .default))
            }
            
            Text(event.name)
                .font(.system(size: 20, weight: .medium, design: .default))
                .frame(maxWidth: .infinity, alignment: .leading)
                .clipped()
            
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity)
    }
}
