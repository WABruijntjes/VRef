//
//  AddStudents_Button.swift
//  VRef_v1
//
//  Created by William on 03/11/2022.
//

import SwiftUI

struct ManageStudents_Button: View {
    
    @Binding var showingManageStudentForm: Bool
    @EnvironmentObject var trainingSessionVM: TrainingSessionViewModel

    
    var body: some View {
        Button(action: {
            showingManageStudentForm.toggle()
            if(trainingSessionVM.studentList.isEmpty){
                trainingSessionVM.getAllStudents()
            }
        }) {
            Text("Manage students")
                .font(.system(size: 25, weight: .medium, design: .default))
                .padding(.all)
                .foregroundColor(.white)
        }
        .background {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color(.sRGB, red: 153/255, green: 15/255, blue: 238/255))
                .frame(width: 300)
                .clipped()
        }
    }
}
