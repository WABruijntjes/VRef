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
    
    func login(credentials: Credentials, completion: @escaping (Result<(User, AccessToken), ErrorHandler.AuthenticationError>) -> Void) {
        
        post(token: nil, urlString: "\(api_url)/user/login", body: credentials, completion: { (result: Result<LoginResponse, Error>, statusCode) in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    
                    // Extract user properties
                    guard let userID = response.user?.id else {
                        print("No userID")
                        return
                    }
                    
                    guard let userEmail = response.user?.email else {
                        print("No email")
                        return
                    }
                    
                    guard let userFirstName = response.user?.firstName else {
                        print("No firstname")
                        return
                    }
                    
                    guard let userLastName = response.user?.lastName else {
                        print("No lastname")
                        return
                    }
                    
                    guard let userOrganization = response.user?.organization else{
                        print("No organization")
                        return
                    }
                    
                    guard let userType = response.user?.userType else{
                        print("No userType")
                        return
                    }
                    
                    //Extract accesstoken properties
                    guard let token = response.accessToken else {
                        print("No accestoken")
                        return
                    }
                    
                    guard let tokenExpire = response.expiresIn else {
                        print("No accestoken expiry")
                        return
                    }
                    
                    guard let tokenType = response.tokenType else {
                        print("No accestoken type")
                        return
                    }
                    
                    let accessToken = AccessToken(token: token, tokenType: tokenType, expiresIn: tokenExpire)
                    let user = User(id: userID, email: userEmail, firstName: userFirstName, lastName: userLastName, organization: userOrganization, userType: userType)
                    
                    let loginResult = (user: user, accessToken: accessToken)
                    completion(.success(loginResult))
                    
                case .failure(let error):
                    print ("-----Login_ERROR>: \(error)")
                    if let statusCode = statusCode {
                        switch statusCode {
                        case 400:
                            completion(.failure(.invalidBodyParameters))
                        case 404:
                            completion(.failure(.requestedObjectNotFound))
                        default:
                            completion(.failure(.authenticationError))
                        }
                    } else {
                        completion(.failure(.authenticationError))
                    }
                }
            }
        })
    }
    
    func createTraining(token: AccessToken, studentIDs: [Int], instructorID: Int,  completion: @escaping (Result<Training, ErrorHandler.APIPostCallError>) -> Void){
        
        post(token: token,urlString: "\(api_url)/training", body: CreateTrainingRequestBody(students: studentIDs, instructorID: instructorID), completion: { (result: Result<Training, Error>, statusCode) in
            
            DispatchQueue.main.async{
                switch result{
                case .success(let response):
                    
                    completion(.success(response))
                    
                case .failure(let error):
                    print ("-----CreateTraining_ERROR>: \(error)")
                    if let statusCode = statusCode {
                        switch statusCode {
                        case 400:
                            completion(.failure(.invalidBodyParameters))
                        case 401:
                            completion(.failure(.notAuthorized))
                        case 403:
                            completion(.failure(.notAuthenticated))
                        default:
                            completion(.failure(.errorCreateNewTraining))
                        }
                    } else {
                        completion(.failure(.errorCreateNewTraining))
                    }
                }
            }
            
        })
        
    }
    
    func startTraining(token: AccessToken, trainingID:Int, completion: @escaping (Result<EmptyResponse, ErrorHandler.APIPostCallError>) -> Void){
        
        post(token: token,urlString: "\(api_url)/training/\(trainingID)/start", body: StartTrainingRequestBody(cameras: []), completion: { (result: Result<EmptyResponse, Error>, statusCode) in
            
            DispatchQueue.main.async{
                switch result{
                case .success:
                    
                    completion(.success(EmptyResponse()))
                    
                case .failure(let error):
                    print ("-----startTrainingSession_ERROR>: \(error)")
                    if let statusCode = statusCode {
                        switch statusCode {
                        case 401:
                            completion(.failure(.notAuthorized))
                        case 403:
                            completion(.failure(.notAuthenticated))
                        case 404:
                            completion(.failure(.requestedObjectNotFound))
                        case 405:
                            completion(.failure(.trainingStateError))
                        default:
                            completion(.failure(.errorCreateNewTraining))
                        }
                    } else {
                        completion(.failure(.errorCreateNewTraining))
                    }
                }
            }
            
        })
        
    }
    
    func stopTraining(token: AccessToken, trainingID: Int, completion: @escaping (Result<EmptyResponse, ErrorHandler.APIPostCallError>) -> Void){
        
        post(token: token,urlString: "\(api_url)/training/\(trainingID)/stop", body: StopTrainingRequestBody(endTrainingSession: true), completion: { (result: Result<EmptyResponse, Error>, statusCode) in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                switch result{
                case .success:
                    
                    completion(.success(EmptyResponse()))
                    
                case .failure(let error):
                    print ("-----stopTrainingSession_ERROR>: \(error)")
                    if let statusCode = statusCode {
                        switch statusCode {
                        case 401:
                            completion(.failure(.notAuthorized))
                        case 403:
                            completion(.failure(.notAuthenticated))
                        case 404:
                            completion(.failure(.requestedObjectNotFound))
                        case 405:
                            completion(.failure(.trainingStateError))
                        default:
                            completion(.failure(.errorStartTraining))
                        }
                    } else {
                        completion(.failure(.errorStartTraining))
                    }
                }
                
            }
        })
    }
    
    func createEvent(token: AccessToken, trainingID: Int, eventDetails: Event, completion: @escaping (Result<Event, ErrorHandler.APIPostCallError>) -> Void){
        
        post(token: token,urlString: "\(api_url)/training/\(trainingID)/event", body: eventDetails, completion: { (result: Result<Event, Error>, statusCode) in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                switch result{
                case .success(let eventResponse):
                    
                    completion(.success(eventResponse))
                    
                case .failure(let error):
                    print ("-----createEvent_ERROR>: \(error)")
                    if let statusCode = statusCode {
                        switch statusCode {
                        case 400:
                            completion(.failure(.invalidBodyParameters))
                        case 401:
                            completion(.failure(.notAuthorized))
                        case 403:
                            completion(.failure(.notAuthenticated))
                        default:
                            completion(.failure(.errorCreateEvent))
                        }
                    } else {
                        completion(.failure(.errorCreateEvent))
                    }
                }
                
            }
        })
    }
    
    func createUser(token: AccessToken, userDetails: User, completion: @escaping (Result<User, ErrorHandler.APIPostCallError>) -> Void){
        post(token: token,urlString: "\(api_url)/user", body: userDetails, completion: { (result: Result<User, Error>, statusCode) in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                switch result{
                case .success(let userResponse):
                    
                    completion(.success(userResponse))
                    
                case .failure(let error):
                    print ("-----createUser_ERROR>: \(error)")
                    if let statusCode = statusCode {
                        switch statusCode {
                        case 400:
                            completion(.failure(.invalidBodyParameters))
                        case 401:
                            completion(.failure(.notAuthorized))
                        default:
                            completion(.failure(.errorCreateUser))
                        }
                    } else {
                        completion(.failure(.errorCreateUser))
                    }
                }
                
            }
        })
    }
    
    func createOrganization(token: AccessToken, organizationDetails: OrganizationNameRequestBody, completion: @escaping (Result<EmptyResponse, ErrorHandler.APIPostCallError>) -> Void){
        post(token: token,urlString: "\(api_url)/organization", body: organizationDetails, completion: { (result: Result<EmptyResponse, Error>, statusCode) in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                switch result{
                case .success:
                    
                    completion(.success(EmptyResponse()))
                    
                case .failure(let error):
                    print ("-----createOrganization_ERROR>: \(error)")
                    if let statusCode = statusCode {
                        switch statusCode {
                        case 400:
                            completion(.failure(.invalidBodyParameters))
                        case 401:
                            completion(.failure(.notAuthorized))
                        case 404:
                            completion(.failure(.requestedObjectNotFound))
                        case 409:
                            completion(.failure(.organizationAlreadyExistsError))
                        default:
                            completion(.failure(.errorCreateOrganization))
                        }
                    } else {
                        completion(.failure(.errorCreateOrganization))
                    }
                }
                
            }
        })
    }
    
    // MARK: GET
    /* ------------------------ GET ----------------------------*/
    
    func getAllTrainingSessions(token: AccessToken,completion: @escaping (Result<[Training], ErrorHandler.APIGetCallError>) -> Void) {
        
        get(token: token, urlString: "\(api_url)/training", completion: { (result: Result<[Training], Error>) in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                switch result{
                case .success(let trainingResponse):
                    
                    completion(.success(trainingResponse))
                    
                case .failure(let error):
                    print ("-----getAllTrainingSessions_ERROR>: \(error)")
                    completion(.failure(.errorGetAllTrainings))
                }
                
            }
        })
    }
    
    func getTrainingByID(trainingID: Int, token: AccessToken,completion: @escaping (Result<Training, ErrorHandler.APIGetCallError>) -> Void) {
        
        get(token: token, urlString: "\(api_url)/training/\(trainingID)", completion: { (result: Result<Training, Error>) in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                switch result{
                case .success(let trainingResponse):
                    
                    completion(.success(trainingResponse))
                    
                case .failure(let error):
                    print ("-----getTrainingByID_ERROR>: \(error)")
                    completion(.failure(.errorGetTrainingByID))
                }
                
            }
        })
    }
    
    func getAllEventsOfTraining(trainingID: Int, token: AccessToken,completion: @escaping (Result<[Event], ErrorHandler.APIGetCallError>) -> Void) {
        
        get(token: token, urlString: "\(api_url)/training/\(trainingID)/event", completion: { (result: Result<[Event], Error>) in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                switch result{
                case .success(let trainingResponse):
                    
                    completion(.success(trainingResponse))
                    
                case .failure(let error):
                    print ("-----getAllTrainingEvents_ERROR>: \(error)")
                    completion(.failure(.errorGetEventsOfTraining))
                }
                
            }
        })
    }
    
    func getUserByID(userID:Int, token: AccessToken,completion: @escaping (Result<User, ErrorHandler.APIGetCallError>) -> Void){
        
        get(token: token, urlString: "\(self.api_url)/user/\(userID)", completion: { (result: Result<User, Error>) in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                switch result{
                case .success(let response):
                    
                    completion(.success(response))
                    
                case .failure(let error):
                    print ("-----GetUserByID_ERROR>: \(error)")
                    completion(.failure(.errorGetUserByID))
                }
            }
            
        })
    }
    
    func getAllUsers(token: AccessToken, completion: @escaping (Result<[User], ErrorHandler.APIGetCallError>) -> Void){
        
        get(token: token, urlString: "\(self.api_url)/user", completion: { (result: Result<[User], Error>) in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                switch result{
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    print ("-----GetAllUsers_ERROR>: \(error)")
                    completion(.failure(.errorGetAllUsers))
                }
            }
            
        })
    }
    
    func getAllOrganizations(token: AccessToken, completion: @escaping (Result<[Organization], ErrorHandler.APIGetCallError>) -> Void){
        
        get(token: token, urlString: "\(self.api_url)/organization", completion: { (result: Result<[Organization], Error>) in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                switch result{
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    print ("-----GetAllOrganizations_ERROR>: \(error)")
                    completion(.failure(.errorGetAllOrganizations))
                }
            }
            
        })
    }
    
    // MARK: PUT
    /* ------------------------ PUT ----------------------------*/
    func updateEvent(token: AccessToken, trainingID: Int, eventID: Int, eventDetails: Event, completion: @escaping (Result<Event, ErrorHandler.APIPutCallError>) -> Void){
        
        put(token: token,urlString: "\(api_url)/training/\(trainingID)/event/\(eventID)", body: eventDetails, completion: { (result: Result<Event, Error>) in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                switch result{
                case .success(let eventResponse):
                    
                    completion(.success(eventResponse))
                    
                case .failure(let error):
                    print ("-----updateEvent_ERROR>: \(error)")
                    completion(.failure(.errorUpdateEvent))
                }
                
            }
        })
    }
    
    func updateUser(token: AccessToken, userID: Int, userDetails: User, completion: @escaping (Result<User, ErrorHandler.APIPutCallError>) -> Void){
        
        put(token: token,urlString: "\(api_url)/user/\(userID)", body: userDetails, completion: { (result: Result<User, Error>) in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                switch result{
                case .success(let userResponse):
                    
                    completion(.success(userResponse))
                    
                case .failure(let error):
                    print ("-----updateUser_ERROR>: \(error)")
                    completion(.failure(.errorUpdateUser))
                }
                
            }
        })
    }
    
    func updateOrganization(token: AccessToken, organizationID: Int, organizationName: OrganizationNameRequestBody, completion: @escaping (Result<EmptyResponse, ErrorHandler.APIPutCallError>) -> Void){
        
        put(token: token,urlString: "\(api_url)/organization/\(organizationID)", body: organizationName, completion: { (result: Result<EmptyResponse, Error>) in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                switch result{
                case .success:
                    
                    completion(.success(EmptyResponse()))
                    
                case .failure(let error):
                    print ("-----updateOrganization_ERROR>: \(error)")
                    completion(.failure(.errorUpdateOrganization))
                }
                
            }
        })
    }
    
    func activateUser(body: ActivationRequestBody, completion: @escaping (Result<EmptyResponse, ErrorHandler.APIPutCallError>) -> Void){
        
        put(token: nil,urlString: "\(api_url)/user/activate", body: body, completion: { (result: Result<EmptyResponse, Error>) in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                switch result{
                case .success:
                    
                    completion(.success(EmptyResponse()))
                    
                case .failure(let error):
                    print ("-----activateUser_ERROR>: \(error)")
                    completion(.failure(.errorActivateUser))
                }
                
            }
        })
    }
    
    // MARK: DELETE
    /* ------------------------ DELETE ----------------------------*/
    
    func deleteEvent(token: AccessToken, trainingID: Int, eventID: Int,completion: @escaping (Result<EmptyResponse, ErrorHandler.APIDeleteCallError>) -> Void){
        delete(token: token, urlString: "\(api_url)/training/\(trainingID)/event/\(eventID)", completion: { (result: Result<EmptyResponse, Error>) in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                switch result{
                case .success:
                    
                    completion(.success(EmptyResponse()))
                    
                case .failure(let error):
                    print ("-----DeleteEvent_ERROR>: \(error)")
                    completion(.failure(.errorDeleteEvent))
                }
            }
        })
    }
    
    func deleteOrganization(token: AccessToken, organizationID: Int,completion: @escaping (Result<EmptyResponse, ErrorHandler.APIDeleteCallError>) -> Void){
        delete(token: token, urlString: "\(api_url)/organization/\(organizationID)", completion: { (result: Result<EmptyResponse, Error>) in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                switch result{
                case .success:
                    
                    completion(.success(EmptyResponse()))
                    
                case .failure(let error):
                    print ("-----DeleteOrganization_ERROR>: \(error)")
                    completion(.failure(.errorDeleteOrganization))
                }
            }
        })
    }
    
    func deleteUser(token: AccessToken, userID: Int,completion: @escaping (Result<EmptyResponse, ErrorHandler.APIDeleteCallError>) -> Void){
        delete(token: token, urlString: "\(api_url)/user/\(userID)", completion: { (result: Result<EmptyResponse, Error>) in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                switch result{
                case .success:
                    
                    completion(.success(EmptyResponse()))
                    
                case .failure(let error):
                    print ("-----DeleteUser_ERROR>: \(error)")
                    completion(.failure(.errorDeleteUser))
                }
            }
        })
    }
}
