//
//  AdminPanelViewModel.swift
//  VRef_v1
//
//  Created by William on 03/01/2023.
//

import Foundation

class AdminPanelViewModel: ObservableObject{
    
    // Declare Variables
    @Published var adminErrorDescription: String = ""
    @Published var adminAlert = false
    
    @Published var loadingUsers = false
    @Published var loadingOrganizations = false
    
    @Published var userList = [User]()
    @Published var organizationList = [Organization]()
    @Published var currentOrganization: Organization?
    
    @Published var selectedUserID: User.ID?
    var selectedUser: User?{
        for user in userList{
            if(user.id == selectedUserID){ return user }
        }
        return nil
    }
    
    @Published var showingOrganizationList = true
    @Published var showingNewUserForm = false
    @Published var showingChangeUserForm = false
    @Published var showingChangeOrganizationBox = false
    @Published var showingNewOrganizationForm = false
    
    @Published var newUserFirstName: String = ""
    @Published var newUserLastName: String = ""
    @Published var newUserEmail: String = ""
    @Published var newUserType: UserType = .Student
    
    @Published var newOrganizationName: String = ""
    
    @Published var organizationNameToChange: String = ""

    var addUserDisabled: Bool {
        newUserFirstName.isEmpty || newUserLastName.isEmpty || newUserEmail.isEmpty
    }
    
    var editUserDisabled: Bool {
        selectedUserID == nil
    }
    
    var addOrganizationDisabled: Bool {
        newOrganizationName.isEmpty
    }
    
    var editOrganizationDisabled: Bool {
        organizationNameToChange.isEmpty
    }
    
    func getAllUsers() {
        
        self.userList = []
        self.loadingUsers = true
        
        // Get the Access Token
        do {
            let token = try UserDefaults.standard.getObject(forKey: "loggedInAccessToken", castTo: AccessToken.self)
            
            guard let currentOrganization = currentOrganization else {
                print("There is no organization to get users for")
                return
            }
            
            // Call the API to get the list of Users
            VRef_API.API.getAllUsers(token: token, completion: { result in
                
                self.loadingUsers = false

                switch result {
                case .success(let users):
                    for user in users{
                        if(user.organization.id == currentOrganization.id){
                            self.userList.append(user)
                        }
                    }
                case .failure(let error):
                    print("error: \(error)")
                    self.adminErrorDescription = error.errorDescription
                    self.adminAlert = true
                }
            })
        } catch {
            print(error.localizedDescription)
            self.adminErrorDescription = error.localizedDescription
            self.adminAlert = true
        }
    }
    
    func getAllOrganizations(){
        
        self.organizationList = []
        self.loadingOrganizations = true
        
        do {
            let token = try UserDefaults.standard.getObject(forKey: "loggedInAccessToken", castTo: AccessToken.self)
            
            // Call the API to get the list of Organizations
            VRef_API.API.getAllOrganizations(token: token, completion: { result in
                
                self.loadingOrganizations = false

                switch result {
                case .success(let organizations):
                    self.organizationList.append(contentsOf: organizations)
                case .failure(let error):
                    print("error: \(error)")
                    self.adminErrorDescription = error.errorDescription
                    self.adminAlert = true
                    self.loadingOrganizations = false
                }
            })
        } catch{
            print(error.localizedDescription)
            self.adminErrorDescription = error.localizedDescription
            self.adminAlert = true
        }
    }
    
    func createOrganization(){
        
        do {
            let token = try UserDefaults.standard.getObject(forKey: "loggedInAccessToken", castTo: AccessToken.self)
            
            VRef_API.API.createOrganization(token: token, organizationDetails: OrganizationNameRequestBody(name: newOrganizationName), completion: { result in
                
                switch result {
                case .success:
                    
                    self.newOrganizationName = ""
                    self.getAllOrganizations()
                    
                case .failure(let error):
                    print("error: \(error)")
                    self.adminErrorDescription = error.errorDescription
                    self.adminAlert = true
                    self.loadingOrganizations = false
                }
            })
        } catch{
            print(error.localizedDescription)
            self.adminErrorDescription = error.localizedDescription
            self.adminAlert = true
        }
        
    }
    
    func changeOrganization(){

        do{
            let token = try UserDefaults.standard.getObject(forKey: "loggedInAccessToken", castTo: AccessToken.self)
            let loggedInUser = try UserDefaults.standard.getObject(forKey: "loggedInUser", castTo: User.self)

            guard let currentOrganization = currentOrganization else {
                print("There is no organization to change the name for")
                return
            }
                        
            VRef_API.API.updateOrganization(token: token, organizationID: currentOrganization.id, organizationName: OrganizationNameRequestBody(name: organizationNameToChange), completion: { result in
                
                switch result {
                case .success:
                    
                    self.organizationNameToChange = ""
                    if(loggedInUser.userType == .SuperAdmin){
                        self.getAllOrganizations()
                    }
                    
                case .failure(let error):
                    print("error: \(error)")
                    self.adminErrorDescription = error.errorDescription
                    self.adminAlert = true
                    self.loadingOrganizations = false
                }
                
            })
                                     
        }catch {
            print(error.localizedDescription)
            self.adminErrorDescription = error.localizedDescription
            self.adminAlert = true
        }
    }
    
    func deleteOrganization(){
        
        do{
            let token = try UserDefaults.standard.getObject(forKey: "loggedInAccessToken", castTo: AccessToken.self)

            guard let currentOrganization = currentOrganization else {
                print("There is no organization to delete")
                return
            }
                        
            VRef_API.API.deleteOrganization(token: token, organizationID: currentOrganization.id, completion: { result in

                switch result {
                case .success:
                    
                    self.currentOrganization = self.organizationList[0]
                    self.getAllOrganizations()
                    self.getAllUsers()
                    
                case .failure(let error):
                    print("error: \(error)")
                    self.adminErrorDescription = error.errorDescription
                    self.adminAlert = true
                    self.loadingOrganizations = false
                }
            })
                                     
        }catch {
            print(error.localizedDescription)
            self.adminErrorDescription = error.localizedDescription
            self.adminAlert = true
        }
    }
    
    func createUser(){
        self.loadingUsers = true
        do {
            let token = try UserDefaults.standard.getObject(forKey: "loggedInAccessToken", castTo: AccessToken.self)
            
            guard let currentOrganization = currentOrganization else {
                print("There is no organization selected to assign a new users to")
                return
            }
            
            let newUser = User(id: -1, email: newUserEmail, firstName: newUserFirstName, lastName: newUserLastName, organization: currentOrganization, userType: .Student)

            
            VRef_API.API.createUser(token: token, userDetails: newUser, completion: { [unowned self](result: Result<User, ErrorHandler.ErrorType>) in

                switch result{
                case .success(var userResult):
                    self.loadingUsers = false
                    userResult.userType = newUserType
                    changeUser(userToChange: userResult) //To assign userType, which can't be done in create function according to API design
                    self.newUserFirstName = ""
                    self.newUserLastName = ""
                    self.newUserEmail = ""
                    self.newUserType = .Student
                    
                case .failure(let error):
                    print("error: \(error)")
                    self.adminErrorDescription = error.errorDescription
                    self.adminAlert = true
                }
            })
        } catch{
            print(error.localizedDescription)
            self.adminErrorDescription = error.localizedDescription
            self.adminAlert = true
        }
        
    }
    
    func changeUser(userToChange: User){
        self.loadingUsers = true

        do{
            let token = try UserDefaults.standard.getObject(forKey: "loggedInAccessToken", castTo: AccessToken.self)
            
            VRef_API.API.updateUser(token: token, userID: userToChange.id, userDetails: userToChange, completion: { result in
                self.loadingUsers = false
                
                switch result {
                case .success:
                    
                    self.getAllUsers()
                    
                case .failure(let error):
                    print("error: \(error)")
                    self.adminErrorDescription = error.errorDescription
                    self.adminAlert = true
                    self.loadingUsers = false
                }
                
            })
                                     
        }catch {
            print(error.localizedDescription)
            self.adminErrorDescription = error.localizedDescription
            self.adminAlert = true
        }
    }
    
    func deleteUser(){
        
        do{
            let token = try UserDefaults.standard.getObject(forKey: "loggedInAccessToken", castTo: AccessToken.self)
            
            guard let selectedUser = selectedUser else {
                print("There is no user selected to delete")
                return
            }
            
            VRef_API.API.deleteUser(token: token, userID: selectedUser.id, completion: { result in
                switch result {
                case .success:
                    
                    self.getAllUsers()
                    
                case .failure(let error):
                    print("error: \(error)")
                    self.adminErrorDescription = error.errorDescription
                    self.adminAlert = true
                    self.loadingUsers = false
                }
            })
                                     
        }catch {
            print(error.localizedDescription)
            self.adminErrorDescription = error.localizedDescription
            self.adminAlert = true
        }
    }
    
}
