//
//  Extensions.swift
//  VRef_v1
//
//  Created by William on 25/10/2022.
//

import Foundation
import SwiftUI
import AVKit
import Combine
import UIKit


extension VRef_API {
    
    func post<Response: Decodable, Body: Encodable>(token: AccessToken?, urlString: String, body: Body, completion: @escaping(Result<Response, Error>, Int?) -> Void){
        guard let url = URL(string: urlString) else { fatalError("Missing URL") }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        if(token != nil){
            request.setValue("\(token!.tokenType) \(token!.token)", forHTTPHeaderField: "Authorization")
        }
        
        guard let postData = try? JSONEncoder().encode(body) else{ return }
        
        request.httpBody = postData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            
            let statusCode = (response as! HTTPURLResponse).statusCode
            print("----------STATUS CODE POST> \(statusCode)")
            
            if Response.self == EmptyResponse.self,
               let response = EmptyResponse() as? Response{
                completion(.success(response), statusCode)
            } else {
                do {
                    let decodedResponse = try JSONDecoder().decode(Response.self, from: data)
                    completion(.success(decodedResponse), statusCode)
                } catch {
                    completion(.failure(error), statusCode)
                }
            }
        }.resume()
    }
    
    func get<Response: Decodable>(token: AccessToken, urlString: String, completion: @escaping (Result<Response, Error>) -> Void){
        guard let url = URL(string: urlString) else { fatalError("Missing URL") }
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        request.setValue("\(token.tokenType) \(token.token)", forHTTPHeaderField: "Authorization")
        
        
        URLSession.shared.dataTask(with: request){ data, response, error in
            
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(Response.self, from: data)
                completion(.success(decodedResponse))
            } catch {
                completion(.failure(error))
            }
            
        }.resume()
    }
    
    func delete<Response: Decodable>(token: AccessToken, urlString: String, completion: @escaping(Result<Response, Error>) -> Void){
        guard let url = URL(string: urlString) else { fatalError("Missing URL") }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        request.setValue("\(token.tokenType) \(token.token)", forHTTPHeaderField: "Authorization")

        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            
            let responseCode = (response as! HTTPURLResponse).statusCode
            print("----------RESPONSE CODE DELETE> \(responseCode)")
            
            if Response.self == EmptyResponse.self,
               let response = EmptyResponse() as? Response {
                completion(.success(response))
            } else {
                do {
                    let decodedResponse = try JSONDecoder().decode(Response.self, from: data)
                    completion(.success(decodedResponse))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func put<Response: Decodable, Body: Encodable>(token: AccessToken?, urlString: String, body: Body, completion: @escaping(Result<Response, Error>) -> Void){
        guard let url = URL(string: urlString) else { fatalError("Missing URL") }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        
        if(token != nil){
            request.setValue("\(token!.tokenType) \(token!.token)", forHTTPHeaderField: "Authorization")
        }
        
        guard let deleteData = try? JSONEncoder().encode(body) else{ return }
        
        request.httpBody = deleteData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            
            let responseCode = (response as! HTTPURLResponse).statusCode
            print("----------RESPONSE CODE PUT> \(responseCode)")
            
            if Response.self == EmptyResponse.self,
               let response = EmptyResponse() as? Response {
                completion(.success(response))
            } else {
                do {
                    let decodedResponse = try JSONDecoder().decode(Response.self, from: data)
                    completion(.success(decodedResponse))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}

//Single corner radius on determined sides
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
//------------------------------------------//

extension AVPlayerViewController {
    func enterFullScreen(animated: Bool) {
        perform(NSSelectorFromString("enterFullScreenAnimated:completionHandler:"), with: animated, with: nil)
    }
    
    func exitFullScreen(animated: Bool) {
        perform(NSSelectorFromString("exitFullScreenAnimated:completionHandler:"), with: animated, with: nil)
    }
}

extension String {
    subscript(i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }
}

extension UserDefaults: ObjectSavable {
    func setObject<Object>(_ object: Object, forKey: String) throws where Object: Encodable {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object)
            set(data, forKey: forKey)
        } catch {
            throw ErrorHandler.ObjectSavableError.unableToEncode
        }
    }
    
    func getObject<Object>(forKey: String, castTo type: Object.Type) throws -> Object where Object: Decodable {
        guard let data = data(forKey: forKey) else { throw ErrorHandler.ObjectSavableError.noValue }
        let decoder = JSONDecoder()
        do {
            let object = try decoder.decode(type, from: data)
            return object
        } catch {
            throw ErrorHandler.ObjectSavableError.unableToDecode
        }
    }
}

extension KeyboardReadable {
    var keyboardPublisher: AnyPublisher<Bool, Never> {
        Publishers.Merge(
            NotificationCenter.default
                .publisher(for: UIResponder.keyboardWillShowNotification)
                .map { _ in true },
            
            NotificationCenter.default
                .publisher(for: UIResponder.keyboardWillHideNotification)
                .map { _ in false }
        )
        .eraseToAnyPublisher()
    }
}

extension UIApplication {
    func closeKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
