//
//  TrainingList.swift
//  VRef_v1
//
//  Created by William on 26/10/2022.
//

import SwiftUI

struct TrainingList: View {
    
    @EnvironmentObject var trainingOverviewVM: TrainingOverviewViewModel
    
    var body: some View {
        //------ Start training list ------//
        VStack(alignment: .leading) {
            Text("Your training sessions")
                .font(.system(size: 35, weight: .semibold, design: .default))
                .padding(.all, 10)
                .foregroundColor(.white)
            Divider()
            ScrollView{
                if(trainingOverviewVM.loadingTrainings){
                    VStack(alignment: .center){
                        ProgressView("Loading training session").progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    }.frame(maxWidth: .infinity)
                }else{
                    LazyVStack {
                        if (trainingOverviewVM.trainingList.isEmpty == false) {
                            ForEach(trainingOverviewVM.trainingList.sorted { $0.creationDateTime > $1.creationDateTime }) { training in
                                TrainingCell(training: training)
                            }
                        }else{
                            Spacer()
                            Text("There are no training sessions in your list.\n Try refreshing by pulling this text down.")
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                        }
                    }
                }
            }
            .refreshable {
                trainingOverviewVM.getAllTrainingSessions()
            }
            Spacer()
        }
        .background {
            Rectangle()
                .fill(Color(.sRGB, red: 41/255, green: 41/255, blue: 41/255))
                .cornerRadius(10, corners: [.topRight, .bottomRight])
                .shadow(color: .black.opacity(1), radius: 8, x: 6, y: 0)
        }
        .frame(width: 650)
        .zIndex(.infinity)
        //------ End training list ------/
    }
}
