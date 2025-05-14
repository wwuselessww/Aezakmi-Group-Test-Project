//
//  RootViewModel.swift
//  Aezakmi Group Test Project
//
//  Created by Alexander Kozharin on 14.05.25.
//

import SwiftUI
import FirebaseAuth

class AppViewModel: ObservableObject {
    @Published var isUserLoggedIn: Bool = false
    @Published var loginError: String?
    
    init() {
        Auth.auth().addStateDidChangeListener { _, user in
            self.isUserLoggedIn = (user != nil)
        }
    }
    
    func register(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                if let error = error as NSError? {
                    switch AuthErrorCode(rawValue: error.code) {
                    case .emailAlreadyInUse:
                        self.loginError = "This email is already in use"
                    default:
                        self.loginError = "unexpected error"
                    }
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error as NSError? {
                switch AuthErrorCode(rawValue: error.code) {
                case .wrongPassword:
                    self.loginError = "Wrong login or password"
                case .invalidEmail:
                    self.loginError = "Wrong login or password"
                case .userNotFound:
                    self.loginError = "User not found"
                case .invalidCredential:
                    self.loginError = "Wrong login or password"
                default:
                    self.loginError = "Unexpected error"
                    
                }
                print(error.localizedDescription)
           
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
}

