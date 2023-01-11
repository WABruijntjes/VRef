//
//  Training_EventList.swift
//  VRef_v1
//
//  Created by William on 06/11/2022.
//

import SwiftUI

struct Training_EventList: View {
    
    @EnvironmentObject var trainingSessionVM: TrainingSessionViewModel
    
    @Binding var eventToChange: Event?
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Text("Quick Feedback")
                Spacer()
                
                Text("Add")
                    .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 15))
            }
            .padding(.horizontal)
            .foregroundColor(Color(.sRGB, red: 132/255, green: 132/255, blue: 132/255))
            
            HStack{
                ZStack(alignment: .leading){
                    if(trainingSessionVM.newQuickEventMessage.isEmpty){
                        Text("Write some quick feedack...")
                            .foregroundColor(.gray)
                            .padding(.horizontal)
                    }
                    TextField("", text: $trainingSessionVM.newQuickEventMessage)
                        .keyboardType(.default)
                        .disableAutocorrection(true)
                        .foregroundColor(.black)
                        .autocapitalization(.sentences)
                        .disableAutocorrection(true)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding(10)
                }
                .background{
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.white)
                }
                
                Button(action: {
                    if(!trainingSessionVM.newEventMessage.isEmpty){
                        trainingSessionVM.createQuickFeedbackEvent()
                    }
                }) {
                    Image(systemName: "arrow.right")
                        .foregroundColor(.white)
                        .frame(width: 50, height: 50)
                        .background(Color(.sRGB, red: 153/255, green: 15/255, blue: 238/255))
                        .clipShape(Circle())
                }
                .disabled(trainingSessionVM.newEventMessage.isEmpty)
                
            }.padding(.horizontal)
            
            ScrollView {
                VStack {
                    if(trainingSessionVM.loadingEvents){
                        ZStack(alignment: .center){
                            Spacer()
                            ProgressView("Loading events").progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        }.frame(maxWidth: .infinity)
                    }
                    else{
                        LazyVStack {
                            if (trainingSessionVM.currentTraining?.events?.isEmpty == false) {
                                ForEach(trainingSessionVM.currentTraining?.events?.reversed() ?? []) { event in
                                    Training_EventCell(eventToChange: $eventToChange, event: event)
                                    
                                }
                            }else{
                                ZStack(alignment: .center){
                                    Spacer()
                                    Text("There are no events in this training").foregroundColor(.gray)
                                }.frame(maxWidth: .infinity)
                            }
                        }
                    }
                }
            }
            .refreshable {
                trainingSessionVM.getEventsOfTraining()
            }
        }
        .padding(.vertical)
        .background {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color(.systemFill))
        }
        .frame(maxWidth: .infinity)
        .clipped()
    }
}
