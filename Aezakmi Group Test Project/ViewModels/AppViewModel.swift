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
    
    
    init() {
            Auth.auth().addStateDidChangeListener { _, user in
                self.isUserLoggedIn = (user != nil)
            }
        }
    
    func register(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error?.localizedDescription)
            }
        }
    }
    
    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error?.localizedDescription)
            }
            print(result)
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
    }

    
}

