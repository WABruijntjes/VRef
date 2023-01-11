//
//  ParticipantRow.swift
//  VRef_v1
//
//  Created by William on 03/11/2022.
//

import SwiftUI

struct StudentRow: View {
    
    @EnvironmentObject var trainingSessionVM: TrainingSessionViewModel
    
    let student: User
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(student.fullName)
                Text(student.email)
                    .underline()
            }
            .padding()
            Spacer()
            Image(systemName: "person.fill.xmark")
                .foregroundColor(Color(.sRGB, red: 253/255, green: 77/255, blue: 77/255))
                .font(.system(size: 30, weight: .regular, design: .default))
//            VStack {
//
//                Text("Student")
//            }
            .padding()
            .onTapGesture {
                if let index = trainingSessionVM.selectedStudents.firstIndex(where: {$0.id == student.id}){
                    trainingSessionVM.selectedStudents.remove(at: index)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .clipped()
    }
}
