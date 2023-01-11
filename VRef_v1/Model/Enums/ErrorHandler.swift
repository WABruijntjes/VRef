//
//  ErrorHandler.swift
//  VRef_v1
//
//  Created by William on 06/12/2022.
//

import Foundation

struct ErrorHandler{
    
    public enum AuthenticationError: Error, LocalizedError, Identifiable{
        case unknownError
        case invalidBodyParameters //400
        case requestedObjectNotFound //404
        
        case authenticationError
        
        var id: String{
            self.localizedDescription
        }
        
        public var errorDescription: String{
            switch self{
            case .unknownError:
                return NSLocalizedString("Unknown error occurred", comment: "")
            case .requestedObjectNotFound:
                return NSLocalizedString("Requested object not found", comment: "")
            case .invalidBodyParameters:
                return NSLocalizedString("Incorrect username or password. Try again", comment: "")
                
            case .authenticationError:
                return NSLocalizedString("Something went wrong while authenticating", comment: "")
            }
        }
        
        static func handleError(statusCode: Int) -> AuthenticationError{
            switch statusCode {
            case 400:
                return .invalidBodyParameters
            case 404:
                return .requestedObjectNotFound
            default:
                return .unknownError
            }
        }
    }
    
    enum APICallError: Error, LocalizedError, Identifiable{
        //Statuscode errors declaration
        case unknownError
        case invalidBodyParameters //400
        case notAuthorized //401
        case notAuthenticated //403
        case requestedObjectNotFound //404
        case trainingStateError //405
        case organizationAlreadyExistsError //409
        
        
        var id: String{
            self.localizedDescription
        }
        
        var errorDescription: String{
            switch self{
            case .unknownError:
                return NSLocalizedString("Unknown error ocurred", comment: "")
                //400
            case .invalidBodyParameters:
                return NSLocalizedString("The parameters you have entered are invalid", comment: "")
                //401
            case .notAuthorized:
                return NSLocalizedString("Not authorized to make this call", comment: "")
                //403
            case .notAuthenticated:
                return NSLocalizedString("Not authenticated to make this call", comment: "")
                //404
            case .requestedObjectNotFound:
                return NSLocalizedString("he requested object could not be found", comment: "")
                //405
            case .trainingStateError:
                return NSLocalizedString("Can't use this method in the current state of the Training", comment: "")
                //409
            case .organizationAlreadyExistsError:
                return NSLocalizedString("An organization with this name already exists", comment: "")
            }
        }
        
        static func handleError(statusCode: Int) -> APICallError{
            switch statusCode {
            case 400:
                return .invalidBodyParameters
            case 404:
                return .requestedObjectNotFound
            default:
                return .unknownError
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
