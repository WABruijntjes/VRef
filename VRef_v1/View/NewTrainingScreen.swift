//
//  NewTrainingScreen.swift
//  VRef_v1
//
//  Created by William on 02/11/2022.
//

import SwiftUI

struct NewTrainingScreen: View {
    
    @EnvironmentObject var trainingSessionVM: TrainingSessionViewModel
    
    @State var showingManageStudentsForm: Bool = false
    @State var username: String = ""
    
    var body: some View {
        ZStack{
            VStack{
                VStack {
                    Text("NEW TRAINING")
                        .font(.system(size: 60, weight: .bold, design: .default))
                        .foregroundColor(Color(.sRGB, red: 169/255, green: 0/255, blue: 247/255))
                    VStack(alignment: .leading) {
                        ForEach(0..<2) { index in
                            if(trainingSessionVM.selectedStudents.indices.contains(index)){
                                StudentRow(student: trainingSessionVM.selectedStudents[index])
                            }else{
                                EmptyStudentRow(showingManageStudentsForm: $showingManageStudentsForm)
                            }
                        }
                        InstructorRow()
                    }
                    .background {
                        RoundedRectangle(cornerRadius: 4, style: .continuous)
                            .fill(Color(.systemFill))
                    }
                    .frame(width: 500)
                    HStack {
                        Spacer()
                            .frame(width: 300)
                            .clipped()
                        Text(Date(), style: .date)
                            .foregroundColor(Color(.sRGB, red: 169/255, green: 0/255, blue: 247/255))
                        
                    }
                    .fixedSize(horizontal: true, vertical: false)
                    VStack(spacing: 20) {
                        ManageStudents_Button(showingManageStudentForm: $showingManageStudentsForm)
                        Cancel_Button()
                    }.padding(.vertical,30)
                }
                .sheet(isPresented: $showingManageStudentsForm) {
                    ManageStudentsInNewTrainingScreen(showingManageStudentsForm: $showingManageStudentsForm, username: $username)
                }
                
                HStack {
                    Spacer()
                    StartTraining_Button()
                }
                .padding(.all)
            }
            .frame(maxHeight: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 4, style: .continuous)
                    .fill(Color(.sRGB, red: 23/255, green: 23/255, blue: 23/255))
            )
            .alert(isPresented: $trainingSessionVM.sessionAlert) {
                Alert(title: Text("Error"),
                      message: Text(trainingSessionVM.sessionErrorDescription),
                      dismissButton: .default(Text("Okay"))
                )
            }
            VStack{
                HStack{
                    Back_Button()
                    Spacer()
                }
                Spacer()
            }.padding()
        }.toolbar(.hidden)
    }
}
