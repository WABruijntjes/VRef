//
//  TrainingCell.swift
//  VRef_v1
//
//  Created by William on 25/10/2022.
//

import SwiftUI

struct TrainingCell: View {
    
    @EnvironmentObject var trainingVM: TrainingOverviewViewModel

    let training: Training

    var body: some View {
        HStack(spacing: 0) {
            ZStack(alignment: .top) {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color(.sRGB, red: 41/255, green: 41/255, blue: 41/255))
                VStack {
                    HStack(spacing: 10) {
                        VStack(alignment: .leading, spacing: 5) {
                            HStack{
                                Text(training.completeDateString)
                                    .font(.system(size: 25, weight: .semibold, design: .default))
                                Text(" | ")
                                if(training.status == TrainingStatus.Finished || training.status == TrainingStatus.Processing){
                                    Text(training.parsedDate , format: .dateTime.hour().minute())
                                        .font(.system(size: 25, weight: .semibold, design: .default))
                                }else{
                                    Image(systemName: "clock.arrow.circlepath")
                                        .imageScale(.large)
                                    Text("In Progress")
                                        .font(.system(size: 25, weight: .semibold, design: .default))
                                }
                                    
                            }
                            .foregroundColor(.white)
                            VStack(alignment: .leading,spacing: 5){
                                HStack {
                                    HStack(spacing: 5) {
                                        Image(systemName: "person.text.rectangle.fill")
                                            .foregroundColor(Color(.sRGB, red: 10/255, green: 90/255, blue: 254/255))
                                        Text(training.instructor.fullName)
                                            .foregroundColor(.white)
                                    }
                                }
                                HStack{
                                    ForEach(training.students){ student in
                                        HStack(spacing: 5) {
                                            Image(systemName: "person")
                                                .imageScale(.medium)
                                                .foregroundColor(Color(.sRGB, red: 10/255, green: 90/255, blue: 254/255))
                                            Text(student.fullName_shortenedFirstName)
                                                .foregroundColor(.white)
                                        }
                                    }
                                }
                            }
                            .font(.system(size: 20, weight: .regular, design: .default))
                            .foregroundColor(.primary)
                        }
                        .frame(maxHeight: .infinity, alignment: .center)
                        .clipped()
                        Spacer()
                        if(training.status == TrainingStatus.Finished || training.status == TrainingStatus.Processing){
                            View_Close_Button(training: training)
                        }else{
                            Continue_Button(training: training)
                        }
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: 80, alignment: .top)
                    .padding(.all)
                    .background {
                        RoundedRectangle(cornerRadius: 0, style: .continuous)
                            .fill(Color(.sRGB, red: 41/255, green: 44/255, blue: 49/255))
                            .shadow(color: .black.opacity(1), radius: 5, x: 0, y: 5)
                    }
                }
            }
        }
    }
}
