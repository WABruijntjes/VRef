//
//  EventCell.swift
//  VRef_v1
//
//  Created by William on 27/10/2022.
//

import SwiftUI

struct EventCell: View {
    
    @State private var collapsed: Bool = true
    
    var event: Event
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 0){
            Button(
                action: { self.collapsed.toggle() },
                label: {
                    HStack(spacing: 10) {
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
                            .font(.system(size: 22, weight: .bold, design: .default))
                            .frame(minWidth: 180, maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 5)
                        VStack {
                            Divider()
                                .overlay(.gray)
                        }
                        .frame(maxWidth: .infinity)
                        
                        Text(event.timeStamp.timeHoursMinutesSeconds)
                            .font(.system(size: 24, weight: .regular, design: .default))
                            .fixedSize()
                        Image(systemName: self.collapsed ? "chevron.compact.down" : "chevron.compact.up")
                            .imageScale(.large)
                            .font(.system(size: 25, weight: .regular, design: .default))
                    }
                    .foregroundColor(.white)
                    .lineLimit(5)
                    .padding()
                    .frame(maxWidth: .infinity)
                }
            )
            .background {
                Rectangle()
                    .fill(Color(.sRGB, red: 50/255, green: 50/255, blue: 50/255))
                    .cornerRadius(10, corners: [.bottomLeft, .topRight, .topLeft])
                    .opacity(self.collapsed ? 0 : 1)
                    .animation(.easeInOut(duration: 0.3), value: collapsed)
            }
            
            VStack() {
                Text(event.message)
                    .padding()
                    .minimumScaleFactor(0.1) // For better text collapsing animation
                    .foregroundColor(.white)
                
            }
            .frame(minWidth: 480, maxWidth: 480, minHeight: 0, maxHeight: collapsed ? 0 : .none, alignment: .leading)
            .clipped()
            .animation(.easeInOut(duration: 0.3), value: collapsed)
            .background {
                Rectangle()
                    .fill(Color(.sRGB, red: 50/255, green: 50/255, blue: 50/255))
                    .cornerRadius(10, corners: [.bottomLeft, .bottomRight])
                    .opacity(self.collapsed ? 0 : 1)
            }
            
        }
    }
}
