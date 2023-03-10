//
//  LoginViewModel.swift
//  VRef_v1
//
//  Created by William on 30/11/2022.
//

import Foundation
import SwiftUI

class LoginViewModel: ObservableObject{
    @Published var loginErrorDescription: String = ""
    @Published var loginAlert = false
    
    @Published var isAuthenticated: Bool = false
    
    @Published var credentials = Credentials(email: "", password: "")
    @Published var loading = false
    
    @Published var showingActivateAccountForm = false
    @Published var activationSuccessAlert = false
    
    @Published var activationCode: String = ""
    @Published var newPassword: String = ""
    @Published var confirmPassword: String = ""
    
    var loginDisabled: Bool {
        credentials.email.isEmpty || credentials.password.isEmpty
    }
    
    var activateDisabled: Bool {
        newPassword != confirmPassword || (activationCode.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) || !isValidPassword(newPassword)
    }
    
    func isValidPassword(_ password: String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z])(?=.*[@#$%^&+=!*]).{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    func login(){
        
        loading = true
        
        VRef_API.API.login(credentials: credentials, completion: { result in
            
            self.loading = false
            
            switch result{
            case .success(let result):
                
                do {
                    try UserDefaults.standard.setObject(result.user, forKey: "loggedInUser")
                    try UserDefaults.standard.setObject(AccessToken(token: result.accessToken, tokenType: result.tokenType, expiresIn: result.expiresIn), forKey: "loggedInAccessToken")
                } catch {
                    print(error.localizedDescription)
                }
                
                DispatchQueue.main.async {
                    self.isAuthenticated = true
                    self.credentials = Credentials(email: "", password: "")
                }
                
            case .failure(let authError):
                self.credentials = Credentials(email: "", password: "")
                self.loginErrorDescription = authError.errorDescription
                self.loginAlert = true
            }
        })
    }
    
    func logout() {
        UserDefaults.standard.dictionaryRepresentation().forEach({ key, value in
            UserDefaults.standard.removeObject(forKey: key)
        })
        DispatchQueue.main.async {
            self.isAuthenticated = false
        }
    }
    
    func activateAccount(){
        
        VRef_API.API.activateUser(body: ActivationRequestBody(activationCode: self.activationCode, password: self.newPassword), completion: { result in
            
            switch result{
            case .success:
                
                DispatchQueue.main.async {
                    self.activationSuccessAlert = true
                    
                    self.activationCode = ""
                    self.newPassword = ""
                    self.confirmPassword = ""
                }
                
            case .failure(let authError):
                self.loginErrorDescription = authError.localizedDescription
                self.loginAlert = true
            }
            
        })
    }
    
}
