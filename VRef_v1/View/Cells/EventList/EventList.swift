//
//  EventList.swift
//  VRef_v1
//
//  Created by William on 26/10/2022.
//

import SwiftUI

struct EventList: View {
    
    @EnvironmentObject var trainingOverviewVM: TrainingOverviewViewModel
    
    var body: some View {
        HStack {
            VStack {
                Spacer()
                    .frame(height: 75)
                    .clipped()
                ScrollView{
                    VStack {
                        if(trainingOverviewVM.loadingEvents){
                            VStack(alignment: .center){
                                ProgressView("Loading events in training session").progressViewStyle(CircularProgressViewStyle(tint: .blue))
                            }.frame(maxWidth: .infinity)
                        }
                        else{
                            LazyVStack {
                                if (trainingOverviewVM.openEventsTraining?.events?.isEmpty == false) {
                                    ForEach(trainingOverviewVM.openEventsTraining?.events ?? []) { event in
                                        EventCell(event: event)

                                    }
                                }else{
                                    Spacer()
                                    Text("There are no events in this training. Try refreshing by pulling this text down").foregroundColor(.gray)
                                }
                            }
                        }
                    }
                }
                .refreshable {
                    trainingOverviewVM.getEventsOfTraining(trainingID: trainingOverviewVM.openEventsTrainingID)
                }
                .padding(.all, 10)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .clipped()
                .background {
                    RoundedRectangle(cornerRadius: 4, style: .continuous)
                        .fill(Color(.sRGB, red: 41/255, green: 41/255, blue: 41/255))
                }
                .zIndex(0)
            }
        }
    }
}
