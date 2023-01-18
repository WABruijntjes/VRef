//
//  Generic_API_Functions.swift
//  VRef_v1
//
//  Created by William on 18/01/2023.
//

import Foundation

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
    
    func get<Response: Decodable>(token: AccessToken, urlString: String, completion: @escaping (Result<Response, Error>, Int?) -> Void){
        guard let url = URL(string: urlString) else { fatalError("Missing URL") }
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        request.setValue("\(token.tokenType) \(token.token)", forHTTPHeaderField: "Authorization")
        
        
        URLSession.shared.dataTask(with: request){ data, response, error in
            
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            
            let statusCode = (response as! HTTPURLResponse).statusCode
            
            do {
                let decodedResponse = try JSONDecoder().decode(Response.self, from: data)
                completion(.success(decodedResponse), statusCode)
            } catch {
                completion(.failure(error), statusCode)
            }
            
        }.resume()
    }
    
    func delete<Response: Decodable>(token: AccessToken, urlString: String, completion: @escaping(Result<Response, Error>, Int?) -> Void){
        guard let url = URL(string: urlString) else { fatalError("Missing URL") }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        request.setValue("\(token.tokenType) \(token.token)", forHTTPHeaderField: "Authorization")

        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            
            let statusCode = (response as! HTTPURLResponse).statusCode
            print("----------STATUS CODE DELETE> \(statusCode)")
            
            if Response.self == EmptyResponse.self,
               let response = EmptyResponse() as? Response {
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
    
    func put<Response: Decodable, Body: Encodable>(token: AccessToken?, urlString: String, body: Body, completion: @escaping(Result<Response, Error>, Int?) -> Void){
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
            
            let statusCode = (response as! HTTPURLResponse).statusCode
            print("----------RESPONSE CODE PUT> \(statusCode)")
            
            if Response.self == EmptyResponse.self,
               let response = EmptyResponse() as? Response {
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
}
