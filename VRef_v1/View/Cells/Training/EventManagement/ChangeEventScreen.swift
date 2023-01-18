//
//  ChangeEventScreen.swift
//  VRef_v1
//
//  Created by William on 02/01/2023.
//

import Foundation
import SwiftUI

struct ChangeEventScreen: View {
    
    @EnvironmentObject var trainingSessionVM: TrainingSessionViewModel
    
    @State var event: Event
    @State var textCharacterLimit: Int = 1000
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView{
                HStack {
                    Text("Change event")
                        .font(.largeTitle.weight(.bold))
                    Text("\(event.timeStamp.hours): \(event.timeStamp.minutes)")
                        .font(.largeTitle.weight(.bold))
                    Spacer()
                    Image(systemName: "xmark")
                        .imageScale(.large)
                        .font(.largeTitle)
                        .onTapGesture {
                            trainingSessionVM.showingChangeEventForm = false
                        }
                }
                .padding(.horizontal)
                .padding(.top)
                HStack(spacing: 30) {
                    VStack(spacing: 0) {
                        Text("Icon")
                            .padding(.bottom)
                            .foregroundColor(Color(.sRGB, red: 132/255, green: 132/255, blue: 132/255))
                        Image(systemName: VRef_Symbols.symbols[event.symbol] ?? "questionmark.circle.fill")
                            .imageScale(.large)
                            .background {
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .frame(width: 70, height: 70)
                                    .foregroundColor(Color(.opaqueSeparator))
                            }
                            .foregroundColor(Color(.sRGB, red: 240/255, green: 233/255, blue: 214/255))
                            .font(.largeTitle)
                    }
                    VStack(alignment: .leading) {
                        Text("Event name")
                            .padding(.bottom)
                            .foregroundColor(Color(.sRGB, red: 132/255, green: 132/255, blue: 132/255))
                        TextField("Type a name for your feedback event here...", text: $event.name)
                            .onChange(of: event.name) { newValue in
                                if newValue.count > self.textCharacterLimit {
                                    event.name = String(newValue.prefix(self.textCharacterLimit))
                                }
                            }
                            .padding(.horizontal)
                            .autocapitalization(.sentences)
                            .foregroundColor(.white)
                            .font(.body)
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(Color(.sRGB, red: 33/255, green: 33/255, blue: 33/255))
                                    .frame(height: 60)
                            )
                    }.padding(.vertical)
                }
                .padding(.horizontal)
                .padding(.bottom)
                VStack(alignment: .leading) {
                    Text("Event description")
                        .foregroundColor(Color(.sRGB, red: 132/255, green: 132/255, blue: 132/255))
                    Spacer()
                    TextField("", text: $event.message, axis: .vertical)
                        .onChange(of: event.message) { newValue in
                            if newValue.count > self.textCharacterLimit {
                                event.message = String(newValue.prefix(self.textCharacterLimit))
                            }
                        }
                        .frame(maxHeight: .infinity, alignment: .top)
                        .lineLimit(11...11)
                        .padding(.all)
                        .autocapitalization(.sentences)
                        .foregroundColor(.white)
                        .font(.body)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(Color(.sRGB, red: 33/255, green: 33/255, blue: 33/255))
                        )
                    HStack{
                        Spacer()
                        Text("Characters left: \(textCharacterLimit - event.message.count)")
                    }
                    .padding(.horizontal)
                }.padding(.horizontal)
                    .frame(maxHeight: .infinity)
                VStack(spacing: 10) {
                    ChangeEvent_Button(eventToChange: event)
                    Cancel_Button()
                    DeleteEvent_Button(eventToDelete: event)
                        .padding(.top, 60)
                }
                .padding(.all, 10)
                Spacer()
            }
        }
    }
}
