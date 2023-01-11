//
//  TrainingViewModel.swift
//  VRef_v1
//
//  Created by William on 04/12/2022.
//

import Foundation

import SwiftUI

class TrainingOverviewViewModel: ObservableObject{
    @Published var overviewErrorDescription: String = ""
    @Published var overviewAlert = false
    
    //Variables for view changes
    @Published var showingEvents = false
    @Published var openEventsTrainingID:Int = -1
    @Published var loadingTrainings = false
    @Published var loadingEvents = false
    
    //Variables for interaction
    @Published var trainingList = [Training]()
    @Published var searchText = ""
    @Published var openEventsTraining:Training?
    
    
    func getAllTrainingSessions(){
        self.loadingTrainings = true
        
        do {
            let token = try UserDefaults.standard.getObject(forKey: "loggedInAccessToken", castTo: AccessToken.self)
            VRef_API.API.getAllTrainingSessions(token: token, completion: { result in
                
                self.loadingTrainings = false
                
                switch result {
                case .success(let trainingSessions):
                    DispatchQueue.main.async {
                        self.trainingList = trainingSessions
                    }
                case .failure(let error):
                    print("error: \(error)")
                    self.overviewErrorDescription = error.errorDescription
                    self.overviewAlert = true
                }
            })
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getEventsOfTraining(trainingID: Int){
        self.loadingEvents = true
        
        do{
            let token = try UserDefaults.standard.getObject(forKey: "loggedInAccessToken", castTo: AccessToken.self)
            
            VRef_API.API.getTrainingByID(trainingID: trainingID, token: token, completion: { result in
                
                self.loadingEvents = false
                
                switch result {
                case .success(let trainingWithEvents):
                    DispatchQueue.main.async {
                        for index in self.trainingList.indices {
                            if(self.trainingList[index].id == trainingID){
                                self.trainingList[index] = trainingWithEvents
                                self.openEventsTraining = self.trainingList[index]
                            }
                        }
                    }
                case .failure(let error):
                    print("error: \(error)")
                    self.overviewErrorDescription = error.errorDescription
                    self.overviewAlert = true
                }
            })
        } catch {
            print(error.localizedDescription)
        }
    }
}
