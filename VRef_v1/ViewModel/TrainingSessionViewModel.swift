//
//  NewTrainingViewModel.swift
//  VRef_v1
//
//  Created by William on 09/12/2022.
//

import Foundation
import SwiftUI

class TrainingSessionViewModel: ObservableObject{
    @Published var sessionErrorDescription: String = ""
    @Published var sessionAlert = false
    
    //New training selector
    @Published var searchText = ""
    @Published var studentList = [User]()
    @Published var loadingStudents = false
    
    //TrainingSession
    @Published var currentTraining: Training?
    @Published var selectedStudents = [User]()
    @Published var loadingEvents = false
    
    @Published var showingAddEventForm = false
    @Published var showingChangeEventForm = false
    @Published var showingExitTrainingForm = false
    @Published var showingSwitchCameraForm = false
        
    @Published var newEventName = ""
    @Published var newEventMessage = ""
    @Published var newQuickEventMessage = ""
    @Published var newEventSymbol = ""
    
    var startTrainingDisabled: Bool {
        selectedStudents.count < 2
    }
    
    var addEventDisabled: Bool {
        newEventName.isEmpty || newEventMessage.isEmpty
    }
    
    var filteredStudents: [User] {
        
        return searchText == "" ? studentList : studentList.filter{
            $0.fullName.lowercased().contains(searchText.lowercased())
        }
    }
    
    func getAllStudents(){
        
        self.studentList = []
        self.loadingStudents = true
        
        do {
            let token = try UserDefaults.standard.getObject(forKey: "loggedInAccessToken", castTo: AccessToken.self)
            VRef_API.API.getAllUsers(token: token, completion: { result in
                
                self.loadingStudents = false
                
                switch result {
                case .success(let users):
                    for user in users{
                        if(user.userType == UserType.Student){
                            self.studentList.append(user)
                        }
                    }
                case .failure(let error):
                    print("error: \(error)")
                    self.sessionErrorDescription = error.errorDescription
                    self.sessionAlert = true
                }
            })
        } catch{
            print(error.localizedDescription)
            self.sessionErrorDescription = error.localizedDescription
            self.sessionAlert = true
        }
    }
    
    func createTraining(){
                
        var selectedStudentIDs = [Int]()
        
        for student in selectedStudents{
            selectedStudentIDs.append(student.id)
        }
        
        do {
            let token = try UserDefaults.standard.getObject(forKey: "loggedInAccessToken", castTo: AccessToken.self)
            let instructor = try UserDefaults.standard.getObject(forKey: "loggedInUser", castTo: User.self)
            
            VRef_API.API.createTraining(token: token, studentIDs: selectedStudentIDs, instructorID: instructor.id, completion: { [unowned self](result: Result<Training, ErrorHandler.ErrorType>) in

                switch result{
                case .success(let trainingResult):
                    
                    VRef_API.API.startTraining(token: token, trainingID: trainingResult.id, completion: {_ in })
                    self.currentTraining = trainingResult
                    
                case .failure(let error):
                    print("error: \(error)")
                    self.sessionErrorDescription = error.errorDescription
                    self.sessionAlert = true
                }
            })
        } catch{
            print(error.localizedDescription)
            self.sessionErrorDescription = error.localizedDescription
            self.sessionAlert = true
        }
        
    }
    
    func continueTraining(training: Training){
        currentTraining = nil
        selectedStudents = []
        currentTraining = training
        for student in training.students {
            selectedStudents.append(student)
        }
        getEventsOfTraining()
    }
    
    func stopTraining(){
        
        do {
            let token = try UserDefaults.standard.getObject(forKey: "loggedInAccessToken", castTo: AccessToken.self)
            
            guard let currentTraining = currentTraining else {
                print("There is no training to stop")
                return
            }
            
            VRef_API.API.stopTraining(token: token, trainingID: currentTraining.id, completion: {_ in })

        }catch{
            print(error.localizedDescription)
            self.sessionErrorDescription = error.localizedDescription
            self.sessionAlert = true
        }
    }
    
    func createQuickFeedbackEvent(){
        
        self.newEventName = "Quick Feedback"
        self.newEventSymbol = "fb_quick"
        
        createEvent()
        
        self.newEventName = ""
        self.newEventSymbol = ""
        self.newEventMessage = ""
    }
    
    func createFeedbackEvent(){
        
        self.newEventSymbol = "fb_manual"
        
        createEvent()
        
        self.newEventName = ""
        self.newEventSymbol = ""
        self.newEventMessage = ""
    }
    
    private func createEvent(){
        
        self.loadingEvents = true
        
        let date = Date()
        let calendar = Calendar.current
        
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        
        let newEvent = Event(id: -1, name: self.newEventName, symbol: self.newEventSymbol, timeStamp: TimeStamp(hours: hour, minutes: minutes, seconds: seconds, miliseconds: 0), message: self.newEventMessage)
        
        do {
            let token = try UserDefaults.standard.getObject(forKey: "loggedInAccessToken", castTo: AccessToken.self)
            
            guard let currentTraining = currentTraining else {
                print("There is no training to create events for")
                return
            }
            
            VRef_API.API.createEvent(token: token, trainingID: currentTraining.id, eventDetails: newEvent, completion: { result in
                
                self.loadingEvents = false
                
                switch result{
                case .success:
                    
                    self.getEventsOfTraining()
                    
                case .failure(let error):
                    print("error: \(error)")
                    self.sessionErrorDescription = error.errorDescription
                    self.sessionAlert = true
                }
            })
            
        } catch{
            print(error.localizedDescription)
            self.sessionErrorDescription = error.localizedDescription
            self.sessionAlert = true
        }
    }
    
    func changeEvent(eventToChange: Event){
        self.loadingEvents = true
        
        guard let currentTraining = currentTraining else {
            print("There is no training to get")
            return
        }
        
        do{
            let token = try UserDefaults.standard.getObject(forKey: "loggedInAccessToken", castTo: AccessToken.self)
            
            VRef_API.API.updateEvent(token: token, trainingID: currentTraining.id, eventID: eventToChange.id, eventDetails: eventToChange, completion: { result in
                self.loadingEvents = false

                switch result{
                case .success:
                    
                    self.getEventsOfTraining()
                    
                case .failure(let error):
                    print("error: \(error)")
                    self.sessionErrorDescription = error.errorDescription
                    self.sessionAlert = true
                }
            })
                                     
        }catch {
            print(error.localizedDescription)
            self.sessionErrorDescription = error.localizedDescription
            self.sessionAlert = true
        }
    }
    
    func deleteEvent(eventToDelete: Event){
        self.loadingEvents = true
        
        guard let currentTraining = currentTraining else {
            print("There is no training to get")
            return
        }
        
        do{
            let token = try UserDefaults.standard.getObject(forKey: "loggedInAccessToken", castTo: AccessToken.self)
            
            VRef_API.API.deleteEvent(token: token, trainingID: currentTraining.id, eventID: eventToDelete.id, completion: { result in
                self.loadingEvents = false

                switch result{
                case .success:
                    
                    self.getEventsOfTraining()
                    
                case .failure(let error):
                    print("error: \(error)")
                    self.sessionErrorDescription = error.errorDescription
                    self.sessionAlert = true
                }
            })
                                     
        }catch {
            print(error.localizedDescription)
            self.sessionErrorDescription = error.localizedDescription
            self.sessionAlert = true
        }
    }
    
    func getEventsOfTraining(){
        
        self.loadingEvents = true
        
        guard let currentTraining = currentTraining else {
            print("There is no training to get")
            return
        }
        
        
        do{
            let token = try UserDefaults.standard.getObject(forKey: "loggedInAccessToken", castTo: AccessToken.self)
            
            VRef_API.API.getTrainingByID(trainingID: currentTraining.id, token: token, completion: { result in
                
                self.loadingEvents = false
                
                switch result {
                case .success(let trainingWithEvents):
                    
                    self.currentTraining = trainingWithEvents
                    
                case .failure(let error):
                    print("error: \(error)")
                    self.sessionErrorDescription = error.errorDescription
                    self.sessionAlert = true
                }
            })
        } catch {
            print(error.localizedDescription)
            self.sessionErrorDescription = error.localizedDescription
            self.sessionAlert = true
        }
    }
    
    
}
