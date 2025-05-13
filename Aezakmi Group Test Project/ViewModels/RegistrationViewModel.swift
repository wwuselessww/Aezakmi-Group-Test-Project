//
//  RegistrationViewModel.swift
//  Aezakmi Group Test Project
//
//  Created by Alexander Kozharin on 13.05.25.
//

import SwiftUI

class RegistrationViewModel: ObservableObject {
    @Published var loginText: String = ""
    @Published var loginError: String?
    
    @Published var passwordText: String = ""
    @Published var passwordError: String?
    
    
    func validateLogin() {
        if loginText.isEmpty {
            loginError = "Email field is empty"
        } else {
            loginError = nil
        }
        
        let loginTest = NSPredicate(format: "SELF MATCHES %@", "^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$")
        
        if !loginTest.evaluate(with: loginText) {
            loginError =  "Email isnt properly formated"
        } else {
            loginError = nil
        }
    }
    
    func validatePassword() {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-zA-Z])(?=.*[0-9!@#$%^&*\\?\\+])(?!.*[()_\\-\\`\\\\/\"\'|\\[\\]}{:;'/>.<,])(?!.*\\s)(?!.*\\s).{8,20}$")
        if !passwordTest.evaluate(with: passwordText) {
            passwordError = "Password should contain special characters"
        } else {
            passwordError = nil
        }
        
        
    }
}
