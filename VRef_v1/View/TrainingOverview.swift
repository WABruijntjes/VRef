//
//  TrainingOverview.swift
//  VRef_v1
//
//  Created by William on 25/10/2022.
//

import SwiftUI

struct TrainingOverview: View {
    
    @EnvironmentObject var trainingOverviewVM: TrainingOverviewViewModel
    
    var body: some View {
        
        NavigationStack {
            
            //------- Start Content container -------//
            HStack(spacing: 0) {
                
                TrainingList()
                
                ZStack{
                    Greeting_NewTraining()
                    if(trainingOverviewVM.showingEvents){
                        EventList()
                            .transition(.move(edge: .leading))
                            .zIndex(2)
                    }
                }
                
            }
            .background {
                RoundedRectangle(cornerRadius: 4, style: .continuous)
                    .fill(Color(.sRGB, red: 23/255, green: 23/255, blue: 23/255))
            }
            .onAppear{
                trainingOverviewVM.getAllTrainingSessions()
            }
            .alert(isPresented: $trainingOverviewVM.overviewAlert) {
                 Alert(title: Text("Error"),
                       message: Text(trainingOverviewVM.overviewErrorDescription),
                 dismissButton: .default(Text("Okay"))
              )
            }
            //------- End Content container -------//
        }.toolbar(.hidden)
    }
}
