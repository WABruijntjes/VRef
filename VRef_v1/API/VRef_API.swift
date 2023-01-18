//
//  VRef_API.swift
//  VRef_v1
//
//  Created by William on 29/11/2022.
//

import Foundation
import Combine
import SwiftUI

class VRef_API: ObservableObject{
    static let API = VRef_API()
    
    private let api_url = URL(string:"https://vrefsolutions-api.azurewebsites.net/api")!
    
    // MARK: POST
    /* ------------------------ POST ----------------------------*/
    
    func login(credentials: Credentials, completion: @escaping (Result<LoginResponse, ErrorHandler.ErrorType>) -> Void) {
        
        post(token: nil, urlString: "\(api_url)/user/login", body: credentials, completion: { (result: Result<LoginResponse, Error>, statusCode) in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    
                    completion(.success(response))
                    
                case .failure(let error):
                    print ("-----Login_ERROR>: \(error)")
                    if let statusCode = statusCode {
                        completion(.failure(ErrorHandler.ErrorType.handleError(statusCode: statusCode)))
                    } else {
                        completion(.failure(.unknownError))
                    }
                }
            }
        })
    }
    
    func createTraining(token: AccessToken, studentIDs: [Int], instructorID: Int,  completion: @escaping (Result<Training, ErrorHandler.ErrorType>) -> Void){
        
        post(token: token,urlString: "\(api_url)/training", body: CreateTrainingRequestBody(students: studentIDs, instructorID: instructorID), completion: { (result: Result<Training, Error>, statusCode) in
            
            DispatchQueue.main.async{
                switch result{
                case .success(let response):
                    
                    completion(.success(response))
                    
                case .failure(let error):
                    print ("-----CreateTraining_ERROR>: \(error)")
                    if let statusCode = statusCode {
                        completion(.failure(ErrorHandler.ErrorType.handleError(statusCode: statusCode)))
                    } else {
                        completion(.failure(.unknownError))
                    }
                }
            }
            
        })
        
    }
    
    func startTraining(token: AccessToken, trainingID:Int, completion: @escaping (Result<EmptyResponse, ErrorHandler.ErrorType>) -> Void){
        
        post(token: token,urlString: "\(api_url)/training/\(trainingID)/start", body: StartTrainingRequestBody(cameras: []), completion: { (result: Result<EmptyResponse, Error>, statusCode) in
            
            DispatchQueue.main.async{
                switch result{
                case .success:
                    
                    completion(.success(EmptyResponse()))
                    
                case .failure(let error):
                    print ("-----startTrainingSession_ERROR>: \(error)")
                    if let statusCode = statusCode {
                        completion(.failure(ErrorHandler.ErrorType.handleError(statusCode: statusCode)))
                    } else {
                        completion(.failure(.unknownError))
                    }
                }
            }
            
        })
        
    }
    
    func stopTraining(token: AccessToken, trainingID: Int, completion: @escaping (Result<EmptyResponse, ErrorHandler.ErrorType>) -> Void){
        
        post(token: token,urlString: "\(api_url)/training/\(trainingID)/stop", body: StopTrainingRequestBody(endTrainingSession: true), completion: { (result: Result<EmptyResponse, Error>, statusCode) in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                switch result{
                case .success:
                    
                    completion(.success(EmptyResponse()))
                    
                case .failure(let error):
                    print ("-----stopTrainingSession_ERROR>: \(error)")
                    if let statusCode = statusCode {
                        completion(.failure(ErrorHandler.ErrorType.handleError(statusCode: statusCode)))
                    } else {
                        completion(.failure(.unknownError))
                    }
                }
                
            }
        })
    }
    
    func createEvent(token: AccessToken, trainingID: Int, eventDetails: Event, completion: @escaping (Result<Event, ErrorHandler.ErrorType>) -> Void){
        
        post(token: token,urlString: "\(api_url)/training/\(trainingID)/event", body: eventDetails, completion: { (result: Result<Event, Error>, statusCode) in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                switch result{
                case .success(let eventResponse):
                    
                    completion(.success(eventResponse))
                    
                case .failure(let error):
                    print ("-----createEvent_ERROR>: \(error)")
                    if let statusCode = statusCode {
                        completion(.failure(ErrorHandler.ErrorType.handleError(statusCode: statusCode)))
                    } else {
                        completion(.failure(.unknownError))
                    }
                }
                
            }
        })
    }
    
    func createUser(token: AccessToken, userDetails: User, completion: @escaping (Result<User, ErrorHandler.ErrorType>) -> Void){
        post(token: token,urlString: "\(api_url)/user", body: userDetails, completion: { (result: Result<User, Error>, statusCode) in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                switch result{
                case .success(let userResponse):
                    
                    completion(.success(userResponse))
                    
                case .failure(let error):
                    print ("-----createUser_ERROR>: \(error)")
                    if let statusCode = statusCode {
                        completion(.failure(ErrorHandler.ErrorType.handleError(statusCode: statusCode)))
                    } else {
                        completion(.failure(.unknownError))
                    }
                }
                
            }
        })
    }
    
    func createOrganization(token: AccessToken, organizationDetails: OrganizationNameRequestBody, completion: @escaping (Result<EmptyResponse, ErrorHandler.ErrorType>) -> Void){
        post(token: token,urlString: "\(api_url)/organization", body: organizationDetails, completion: { (result: Result<EmptyResponse, Error>, statusCode) in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                switch result{
                case .success:
                    
                    completion(.success(EmptyResponse()))
                    
                case .failure(let error):
                    print ("-----createOrganization_ERROR>: \(error)")
                    if let statusCode = statusCode {
                        completion(.failure(ErrorHandler.ErrorType.handleError(statusCode: statusCode)))
                    } else {
                        completion(.failure(.unknownError))
                    }
                }
                
            }
        })
    }
    
    // MARK: GET
    /* ------------------------ GET ----------------------------*/
    
    func getAllTrainingSessions(token: AccessToken,completion: @escaping (Result<[Training], ErrorHandler.ErrorType>) -> Void) {
        
        get(token: token, urlString: "\(api_url)/training", completion: { (result: Result<[Training], Error>, statusCode) in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                switch result{
                case .success(let trainingResponse):
                    
                    completion(.success(trainingResponse))
                    
                case .failure(let error):
                    print ("-----getAllTrainingSessions_ERROR>: \(error)")
                    if let statusCode = statusCode {
                        completion(.failure(ErrorHandler.ErrorType.handleError(statusCode: statusCode)))
                    } else {
                        completion(.failure(.unknownError))
                    }
                }
                
            }
        })
    }
    
    func getTrainingByID(trainingID: Int, token: AccessToken,completion: @escaping (Result<Training, ErrorHandler.ErrorType>) -> Void) {
        
        get(token: token, urlString: "\(api_url)/training/\(trainingID)", completion: { (result: Result<Training, Error>, statusCode) in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                switch result{
                case .success(let trainingResponse):
                    
                    completion(.success(trainingResponse))
                    
                case .failure(let error):
                    print ("-----getTrainingByID_ERROR>: \(error)")
                    if let statusCode = statusCode {
                        completion(.failure(ErrorHandler.ErrorType.handleError(statusCode: statusCode)))
                    } else {
                        completion(.failure(.unknownError))
                    }
                }
                
            }
        })
    }
    
    func getAllEventsOfTraining(trainingID: Int, token: AccessToken,completion: @escaping (Result<[Event], ErrorHandler.ErrorType>) -> Void) {
        
        get(token: token, urlString: "\(api_url)/training/\(trainingID)/event", completion: { (result: Result<[Event], Error>, statusCode) in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                switch result{
                case .success(let trainingResponse):
                    
                    completion(.success(trainingResponse))
                    
                case .failure(let error):
                    print ("-----getAllTrainingEvents_ERROR>: \(error)")
                    if let statusCode = statusCode {
                        completion(.failure(ErrorHandler.ErrorType.handleError(statusCode: statusCode)))
                    } else {
                        completion(.failure(.unknownError))
                    }
                }
                
            }
        })
    }
    
    func getUserByID(userID:Int, token: AccessToken,completion: @escaping (Result<User, ErrorHandler.ErrorType>) -> Void){
        
        get(token: token, urlString: "\(self.api_url)/user/\(userID)", completion: { (result: Result<User, Error>, statusCode) in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                switch result{
                case .success(let response):
                    
                    completion(.success(response))
                    
                case .failure(let error):
                    print ("-----GetUserByID_ERROR>: \(error)")
                    if let statusCode = statusCode {
                        completion(.failure(ErrorHandler.ErrorType.handleError(statusCode: statusCode)))
                    } else {
                        completion(.failure(.unknownError))
                    }
                }
            }
            
        })
    }
    
    func getAllUsers(token: AccessToken, completion: @escaping (Result<[User], ErrorHandler.ErrorType>) -> Void){
        
        get(token: token, urlString: "\(self.api_url)/user", completion: { (result: Result<[User], Error>, statusCode) in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                switch result{
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    print ("-----GetAllUsers_ERROR>: \(error)")
                    if let statusCode = statusCode {
                        completion(.failure(ErrorHandler.ErrorType.handleError(statusCode: statusCode)))
                    } else {
                        completion(.failure(.unknownError))
                    }
                }
            }
            
        })
    }
    
    func getAllOrganizations(token: AccessToken, completion: @escaping (Result<[Organization], ErrorHandler.ErrorType>) -> Void){
        
        get(token: token, urlString: "\(self.api_url)/organization", completion: { (result: Result<[Organization], Error>, statusCode) in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                switch result{
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    print ("-----GetAllOrganizations_ERROR>: \(error)")
                    if let statusCode = statusCode {
                        completion(.failure(ErrorHandler.ErrorType.handleError(statusCode: statusCode)))
                    } else {
                        completion(.failure(.unknownError))
                    }
                }
            }
            
        })
    }
    
    // MARK: PUT
    /* ------------------------ PUT ----------------------------*/
    func updateEvent(token: AccessToken, trainingID: Int, eventID: Int, eventDetails: Event, completion: @escaping (Result<Event, ErrorHandler.ErrorType>) -> Void){
        
        put(token: token,urlString: "\(api_url)/training/\(trainingID)/event/\(eventID)", body: eventDetails, completion: { (result: Result<Event, Error>, statusCode) in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                switch result{
                case .success(let eventResponse):
                    
                    completion(.success(eventResponse))
                    
                case .failure(let error):
                    print ("-----updateEvent_ERROR>: \(error)")
                    if let statusCode = statusCode {
                        completion(.failure(ErrorHandler.ErrorType.handleError(statusCode: statusCode)))
                    } else {
                        completion(.failure(.unknownError))
                    }
                }
                
            }
        })
    }
    
    func updateUser(token: AccessToken, userID: Int, userDetails: User, completion: @escaping (Result<User, ErrorHandler.ErrorType>) -> Void){
        
        put(token: token,urlString: "\(api_url)/user/\(userID)", body: userDetails, completion: { (result: Result<User, Error>, statusCode) in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                switch result{
                case .success(let userResponse):
                    
                    completion(.success(userResponse))
                    
                case .failure(let error):
                    print ("-----updateUser_ERROR>: \(error)")
                    if let statusCode = statusCode {
                        completion(.failure(ErrorHandler.ErrorType.handleError(statusCode: statusCode)))
                    } else {
                        completion(.failure(.unknownError))
                    }
                }
                
            }
        })
    }
    
    func updateOrganization(token: AccessToken, organizationID: Int, organizationName: OrganizationNameRequestBody, completion: @escaping (Result<EmptyResponse, ErrorHandler.ErrorType>) -> Void){
        
        put(token: token,urlString: "\(api_url)/organization/\(organizationID)", body: organizationName, completion: { (result: Result<EmptyResponse, Error>, statusCode) in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                switch result{
                case .success:
                    
                    completion(.success(EmptyResponse()))
                    
                case .failure(let error):
                    print ("-----updateOrganization_ERROR>: \(error)")
                    if let statusCode = statusCode {
                        completion(.failure(ErrorHandler.ErrorType.handleError(statusCode: statusCode)))
                    } else {
                        completion(.failure(.unknownError))
                    }
                }
                
            }
        })
    }
    
    func activateUser(body: ActivationRequestBody, completion: @escaping (Result<EmptyResponse, ErrorHandler.ErrorType>) -> Void){
        
        put(token: nil,urlString: "\(api_url)/user/activate", body: body, completion: { (result: Result<EmptyResponse, Error>, statusCode) in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                switch result{
                case .success:
                    
                    completion(.success(EmptyResponse()))
                    
                case .failure(let error):
                    print ("-----activateUser_ERROR>: \(error)")
                    if let statusCode = statusCode {
                        completion(.failure(ErrorHandler.ErrorType.handleError(statusCode: statusCode)))
                    } else {
                        completion(.failure(.unknownError))
                    }
                }
                
            }
        })
    }
    
    // MARK: DELETE
    /* ------------------------ DELETE ----------------------------*/
    
    func deleteEvent(token: AccessToken, trainingID: Int, eventID: Int,completion: @escaping (Result<EmptyResponse, ErrorHandler.ErrorType>) -> Void){
        delete(token: token, urlString: "\(api_url)/training/\(trainingID)/event/\(eventID)", completion: { (result: Result<EmptyResponse, Error>, statusCode) in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                switch result{
                case .success:
                    
                    completion(.success(EmptyResponse()))
                    
                case .failure(let error):
                    print ("-----DeleteEvent_ERROR>: \(error)")
                    if let statusCode = statusCode {
                        completion(.failure(ErrorHandler.ErrorType.handleError(statusCode: statusCode)))
                    } else {
                        completion(.failure(.unknownError))
                    }
                }
            }
        })
    }
    
    func deleteOrganization(token: AccessToken, organizationID: Int,completion: @escaping (Result<EmptyResponse, ErrorHandler.ErrorType>) -> Void){
        delete(token: token, urlString: "\(api_url)/organization/\(organizationID)", completion: { (result: Result<EmptyResponse, Error>, statusCode) in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                switch result{
                case .success:
                    
                    completion(.success(EmptyResponse()))
                    
                case .failure(let error):
                    print ("-----DeleteOrganization_ERROR>: \(error)")
                    if let statusCode = statusCode {
                        completion(.failure(ErrorHandler.ErrorType.handleError(statusCode: statusCode)))
                    } else {
                        completion(.failure(.unknownError))
                    }
                }
            }
        })
    }
    
    func deleteUser(token: AccessToken, userID: Int,completion: @escaping (Result<EmptyResponse, ErrorHandler.ErrorType>) -> Void){
        delete(token: token, urlString: "\(api_url)/user/\(userID)", completion: { (result: Result<EmptyResponse, Error>, statusCode) in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                switch result{
                case .success:
                    
                    completion(.success(EmptyResponse()))
                    
                case .failure(let error):
                    print ("-----DeleteUser_ERROR>: \(error)")
                    if let statusCode = statusCode {
                        completion(.failure(ErrorHandler.ErrorType.handleError(statusCode: statusCode)))
                    } else {
                        completion(.failure(.unknownError))
                    }
                }
            }
        })
    }
}
