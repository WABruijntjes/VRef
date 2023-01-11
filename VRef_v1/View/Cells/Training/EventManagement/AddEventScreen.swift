//
//  AddEventScreen.swift
//  VRef_v1
//
//  Created by William on 23/12/2022.
//

import SwiftUI

struct AddEventScreen: View {
    
    @EnvironmentObject var trainingSessionVM: TrainingSessionViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView{
                HStack {
                    Text("Add new event - ")
                        .font(.largeTitle.weight(.bold))
                    Text(Date.now, format: .dateTime.hour().minute())
                        .font(.largeTitle.weight(.bold))
                    Spacer()
                    Image(systemName: "xmark")
                        .imageScale(.large)
                        .font(.largeTitle)
                        .onTapGesture {
                            trainingSessionVM.showingAddEventForm = false
                        }
                }
                .padding(.horizontal)
                .padding(.top)
                HStack(spacing: 30) {
                    VStack(spacing: 0) {
                        Text("Icon")
                            .padding(.bottom)
                            .foregroundColor(Color(.sRGB, red: 132/255, green: 132/255, blue: 132/255))
                        Image(systemName: "text.bubble.fill")
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
                        TextField("Type a name for your feedback event here...", text: $trainingSessionVM.newEventName)
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
                    TextField("", text: $trainingSessionVM.newEventMessage, axis: .vertical)
                        .frame(maxHeight: .infinity, alignment: .top)
                        .lineLimit(19...19)
                        .padding(.all)
                        .autocapitalization(.sentences)
                        .foregroundColor(.white)
                        .font(.body)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(Color(.sRGB, red: 33/255, green: 33/255, blue: 33/255))
                        )
                }.padding(.horizontal)
                .frame(maxHeight: .infinity)
                HStack {
                    Cancel_Button()
                    Spacer()
                    AddEvent_Button()
                        
                }
                .padding(.all, 20)
            }
        }
    }
}
