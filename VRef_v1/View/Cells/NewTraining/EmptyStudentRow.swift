//
//  EmptyParticipantRow.swift
//  VRef_v1
//
//  Created by William on 03/11/2022.
//

import SwiftUI

struct EmptyStudentRow: View {
    
    @EnvironmentObject var trainingSessionVM: TrainingSessionViewModel
    
    @Binding var showingManageStudentsForm: Bool

    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("No student has been assigned this slot")
                .foregroundColor(.gray)
                Text("")
                
            }
            .padding()
            Spacer()
            Image(systemName: "person.badge.plus")
                .font(.system(size: 30, weight: .regular, design: .default))
//            VStack {
//                
//                Text("Student")
//            }
            .padding()
            
        }
        .frame(maxWidth: .infinity)
        .clipped()
        .onTapGesture {
            showingManageStudentsForm.toggle()
            if(trainingSessionVM.studentList.isEmpty){
                trainingSessionVM.getAllStudents()
            }
        }
    }
}
