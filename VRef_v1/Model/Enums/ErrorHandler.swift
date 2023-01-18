//
//  ErrorHandler.swift
//  VRef_v1
//
//  Created by William on 06/12/2022.
//

//
//  ErrorHandler.swift
//  VRef_v1
//
//  Created by William on 06/12/2022.
//

import Foundation

struct ErrorHandler {
    
    public enum ErrorType: Error, LocalizedError, Identifiable {
        case unknownError
        case invalidBodyParameters // 400
        case requestedObjectNotFound // 404
        case notAuthorized // 401
        case notAuthenticated // 403
        case trainingStateError // 405
        case nameAlreadyExists // 409
        
        var id: String {
            self.localizedDescription
        }
        
        public var errorDescription: String {
            switch self {
            case .unknownError:
                return NSLocalizedString("Unknown error occurred", comment: "")
            case .requestedObjectNotFound:
                return NSLocalizedString("Requested object not found", comment: "")
            case .invalidBodyParameters:
                return NSLocalizedString("Incorrect parameters entered. Try again", comment: "")
            case .notAuthorized:
                return NSLocalizedString("Not authorized to make this call", comment: "")
            case .notAuthenticated:
                return NSLocalizedString("Not authenticated to make this call", comment: "")
            case .trainingStateError:
                return NSLocalizedString("Can't use this method in the current state of the Training", comment: "")
            case .nameAlreadyExists:
                return NSLocalizedString("The name you're attempting to assign already exists within the database", comment: "")
            }
        }
        
        static func handleError(statusCode: Int) -> ErrorType {
            switch statusCode {
            case 400:
                return .invalidBodyParameters
            case 401:
                return .notAuthorized
            case 403:
                return .notAuthenticated
            case 404:
                return .requestedObjectNotFound
            case 405:
                return .trainingStateError
            case 409:
                return .nameAlreadyExists
            default:
                return .unknownError
            }
        }
    }
    
    enum ObjectSavableError: String, LocalizedError {
        case unableToEncode
        case unableToDecode
        case noValue
        
        var errorDescription: String? {
            switch self {
            case .unableToEncode:
                return NSLocalizedString("Unable to encode object into data", comment: "")
            case .unableToDecode:
                return NSLocalizedString("Unable to decode object into given type", comment: "")
            case .noValue:
                return NSLocalizedString("No data object found for the given key", comment: "")
            }
        }
    }
}
