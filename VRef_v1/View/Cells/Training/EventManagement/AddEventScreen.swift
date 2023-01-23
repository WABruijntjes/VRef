//
//  AddEventScreen.swift
//  VRef_v1
//
//  Created by William on 23/12/2022.
//

import SwiftUI

struct AddEventScreen: View {
    
    @EnvironmentObject var trainingSessionVM: TrainingSessionViewModel
    
    @State var nameCharacterLimit: Int = 100
    @State var messageCharacterLimit: Int = 1000
    
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
                            .onChange(of: trainingSessionVM.newEventName) { nameValue in
                                if nameValue.count > self.nameCharacterLimit {
                                    trainingSessionVM.newEventName = String(nameValue.prefix(self.nameCharacterLimit))
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
                    TextField("", text: $trainingSessionVM.newEventMessage, axis: .vertical)
                        .onChange(of: trainingSessionVM.newEventMessage) { messageValue in
                            if messageValue.count > self.messageCharacterLimit {
                                trainingSessionVM.newEventMessage = String(messageValue.prefix(self.messageCharacterLimit))
                            }
                        }
                        .frame(maxHeight: .infinity, alignment: .top)
                        .lineLimit(18...18)
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
                        Text("Characters left: \(messageCharacterLimit - trainingSessionVM.newEventMessage.count)")
                    }
                }.padding(.horizontal)
                    .frame(maxHeight: .infinity)
                HStack {
                    Cancel_Button()
                    Spacer()
                    AddEvent_Button()
                    
                }
                .padding(.vertical, 15)
                .padding(.horizontal, 20)
            }
        }
    }
}
