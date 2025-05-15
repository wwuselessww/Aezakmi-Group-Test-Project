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
    @Published var isCheckingAuth: Bool = true
    
    init() {
        Auth.auth().addStateDidChangeListener { _, user in
            self.isUserLoggedIn = user != nil
            self.isCheckingAuth = false
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
    
    func resetPassword(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error as NSError? {
                switch AuthErrorCode(rawValue: error.code) {
                case .userNotFound:
                    print("No user found with this email.")
                case .invalidRecipientEmail:
                    print("Invalid recipient email.")
                case .invalidSender:
                    print("Invalid sender.")
                case .invalidMessagePayload:
                    print("Invalid message payload.")
                default:
                    print("Reset password error: \(error.localizedDescription)")
                }
            } else {
                print("✅ Password reset email sent successfully.")
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

