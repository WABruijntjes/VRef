//
//  AddStudentsScreen.swift
//  VRef_v1
//
//  Created by William on 05/11/2022.
//

import SwiftUI

struct ManageStudentsInNewTrainingScreen: View {
    
    @EnvironmentObject var trainingSessionVM: TrainingSessionViewModel
    
    @Binding var showingManageStudentsForm: Bool
    @Binding var username: String
    
    var body: some View {
        VStack{
            VStack(alignment: .leading){
                HStack(spacing: 150) {
                    Text("Add Student(s)")
                        .font(.largeTitle)
                    Spacer()
                    Image(systemName: "xmark")
                        .imageScale(.large)
                        .font(.system(size: 30, weight: .regular, design: .default))
                        .onTapGesture {
                            showingManageStudentsForm = false
                        }
                }
                .padding()
                Spacer()
                HStack{
                    Text("Search student")
                        .padding(.horizontal)
                        .foregroundColor(Color(.sRGB, red: 132/255, green: 132/255, blue: 132/255))
                    Spacer()
                }
                HStack{
                    ZStack{
                        TextField(
                            "first name / last name / e-mail",
                            text: $trainingSessionVM.searchText
                        )
                        .padding(.all)
                        .background(Color(.sRGB, red: 33/255, green: 33/255, blue: 33/255))
                        .padding(.horizontal)
                        Divider()
                            .padding(.horizontal, 25)
                            .frame(width: 650, height: 4)
                            .overlay(Color(.sRGB, red: 169/255, green: 0/255, blue: 247/255))
                            .offset(y: 15)
                    }
                    Spacer()
                }
                Spacer().frame(height: 25)
                HStack{
                    Text("Students")
                        .padding(.horizontal)
                        .foregroundColor(Color(.sRGB, red: 132/255, green: 132/255, blue: 132/255))
                }
                ScrollView {
                    if(trainingSessionVM.loadingStudents){
                        ProgressView("Loading students").progressViewStyle(CircularProgressViewStyle(tint: .blue)).padding(.all)
                    }
                    LazyVStack(){
                        ForEach(trainingSessionVM.filteredStudents.sorted { $0.fullName < $1.fullName }) { student in
                            Text(student.fullName)
                                .foregroundColor(trainingSessionVM.selectedStudents.contains(where: { $0.id == student.id }) ? Color(.sRGB, red: 153/255, green: 15/255, blue: 238/255) : .white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.system(size: 20, weight: trainingSessionVM.selectedStudents.contains(where: { $0.id == student.id }) ? .semibold : .regular, design: .default))
                                .padding(.all)
                                .background {
                                    Rectangle()
                                        .fill(Color(.sRGB, red: 41/255, green: 41/255, blue: 41/255))   
                                }
                                .onTapGesture {
                                    if(!trainingSessionVM.selectedStudents.contains(where: { $0.id == student.id }) && trainingSessionVM.selectedStudents.count < 2){
                                        trainingSessionVM.selectedStudents.append(student)
                                    }else{
                                        if let index = trainingSessionVM.selectedStudents.firstIndex(where: {$0.id == student.id}){
                                            trainingSessionVM.selectedStudents.remove(at: index)
                                        }
                                    }
                                }
                        }
                    }
                    .padding(.all)
                }
                .refreshable {
                    trainingSessionVM.getAllStudents()
                }
                .background {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(Color(.sRGB, red: 33/255, green: 33/255, blue: 33/255))
                }
                .padding(.horizontal)
                
                Spacer()
                HStack{
                    Text("Selected students")
                        .padding(.horizontal)
                        .foregroundColor(Color(.sRGB, red: 132/255, green: 132/255, blue: 132/255))
                    Spacer()
                }
                LazyVStack() {
                    ForEach(trainingSessionVM.selectedStudents) { student in
                        HStack{
                            Text(student.fullName)
                                .font(.system(size: 20, weight: .regular, design: .default))
                            Spacer()
                            Image(systemName: "xmark")
                                .foregroundColor(Color(.sRGB, red: 253/255, green: 77/255, blue: 77/255))
                                .font(.system(size: 30, weight: .regular, design: .default))
                                .onTapGesture {
                                    if let index = trainingSessionVM.selectedStudents.firstIndex(where: {$0.id == student.id}){
                                        trainingSessionVM.selectedStudents.remove(at: index)
                                    }
                                }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.all)
                        .background {
                            Rectangle()
                                .fill(Color(.sRGB, red: 41/255, green: 41/255, blue: 41/255))
                            
                        }
                    }
                }
                .frame(maxHeight: 150)
                .background {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(Color(.sRGB, red: 33/255, green: 33/255, blue: 33/255))
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
            Confirm_Button()
            Spacer()
        }
    }
}
