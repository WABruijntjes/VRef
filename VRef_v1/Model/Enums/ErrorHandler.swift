//
//  ErrorHandler.swift
//  VRef_v1
//
//  Created by William on 06/12/2022.
//

import Foundation

struct ErrorHandler{
    
    public enum AuthenticationError: Error, LocalizedError, Identifiable{
        case requestedObjectNotFound
        case invalidBodyParameters
        
        case authenticationError

        
        
        var id: String{
            self.localizedDescription
        }
        
        public var errorDescription: String{
            switch self{
            case .requestedObjectNotFound:
                return NSLocalizedString("Requested object not found", comment: "")
            case .invalidBodyParameters:
                return NSLocalizedString("Incorrect username or password. Try again", comment: "")
                
            case .authenticationError:
                return NSLocalizedString("Something went wrong while authenticating", comment: "")
            }
        }
    }
    
    enum APIGetCallError: Error, LocalizedError, Identifiable{
        case errorGetAllTrainings
        case errorGetAllUsers
        case errorGetTrainingByID
        case errorGetEventsOfTraining
        case errorGetUserByID
        case errorGetAllOrganizations
        
        
        var id: String{
            self.localizedDescription
        }
        
        var errorDescription: String{
            switch self{
            case .errorGetAllTrainings:
                return NSLocalizedString("Something went wrong getting all training sessions", comment: "")
            case .errorGetAllUsers:
                return NSLocalizedString("Something went wrong getting all users", comment: "")
            case .errorGetTrainingByID:
                return NSLocalizedString("Something went wrong getting a training by ID", comment: "")
            case .errorGetEventsOfTraining:
                return NSLocalizedString("Something went wrong getting the events of this training", comment: "")
            case .errorGetUserByID:
                return NSLocalizedString("Something went wrong getting the user by ID", comment: "")
            case .errorGetAllOrganizations:
                return NSLocalizedString("Something went wrong getting all organizations. Pull the list down to try and refresh", comment: "")
            }
            
            
        }
    }
    
    enum APIPostCallError: Error, LocalizedError, Identifiable{
        //Statuscode errors declaration
        case invalidBodyParameters
        case notAuthorized
        case notAuthenticated
        case requestedObjectNotFound
        case trainingStateError
        case organizationAlreadyExistsError
        
        //Custom errors declaration
        case errorCreateNewTraining
        case errorStartTraining
        case errorCreateEvent
        case errorCreateOrganization
        case errorStopTraining
        case errorCreateUser
        
        
        var id: String{
            self.localizedDescription
        }
        
        var errorDescription: String{
            switch self{
                //400
            case .invalidBodyParameters:
                return NSLocalizedString("Invalid body parameters", comment: "")
                //401
            case .notAuthorized:
                return NSLocalizedString("Not authorized to make this call", comment: "")
                //403
            case .notAuthenticated:
                return NSLocalizedString("Not authenticated to make this call", comment: "")
                //404
            case .requestedObjectNotFound:
                return NSLocalizedString("Requested object not found", comment: "")
                //405
            case .trainingStateError:
                return NSLocalizedString("Can't use this method in the current state of the Training object", comment: "")
                //409
            case .organizationAlreadyExistsError:
                return NSLocalizedString("An organization with this name already exists", comment: "")
                
                //Custom errors
            case .errorCreateNewTraining:
                return NSLocalizedString("Something went wrong creating a new training session", comment: "")
            case .errorStartTraining:
                return NSLocalizedString("Something went wrong starting the training session", comment: "")
            case .errorCreateEvent:
                return NSLocalizedString("Something went wrong creating an event for the training session", comment: "")
            case .errorCreateOrganization:
                return NSLocalizedString("Something went wrong creating an organization", comment: "")
            case .errorStopTraining:
                return NSLocalizedString("Something went wrong stopping the training session", comment: "")
            case .errorCreateUser:
                return NSLocalizedString("Something went wrong creating a new user", comment: "")
            }
        }
    }
    
    enum APIPutCallError: Error, LocalizedError, Identifiable{
        case errorUpdateEvent
        case errorUpdateUser
        case errorUpdateOrganization
        case errorActivateUser
        
        var id: String{
            self.localizedDescription
        }
        
        var errorDescription: String{
            switch self{
            case .errorUpdateEvent:
                return NSLocalizedString("Something went wrong updating the event. The details have not been changed", comment: "")
            case .errorUpdateUser:
                return NSLocalizedString("Something went wrong updating the user. The details have not been changed", comment: "")
            case .errorUpdateOrganization:
                return NSLocalizedString("Something went wrong updating the organization. The details have not been changed", comment: "")
            case .errorActivateUser:
                return NSLocalizedString("Something went wrong activating your account. Try again", comment: "")
            }
        }
    }
    
    enum APIDeleteCallError: Error, LocalizedError, Identifiable{
        case errorDeleteEvent
        case errorDeleteUser
        case errorDeleteOrganization
        
        var id: String{
            self.localizedDescription
        }
        
        var errorDescription: String{
            switch self{
            case .errorDeleteEvent:
                return NSLocalizedString("Something went wrong deleting the event", comment: "")
            case .errorDeleteUser:
                return NSLocalizedString("Something went wrong deleting the user", comment: "")
            case .errorDeleteOrganization:
                return NSLocalizedString("Something went wrong deleting the organization", comment: "")
            }
        }
    }
    
    enum ObjectSavableError: String, LocalizedError {
        case unableToEncode = "Unable to encode object into data"
        case noValue = "No data object found for the given key"
        case unableToDecode = "Unable to decode object into given type"
        
        var errorDescription: String? {
            rawValue
        }
    }
}
