//
//  RegistrationViewModel.swift
//  Aezakmi Group Test Project
//
//  Created by Alexander Kozharin on 14.05.25.
//

import Foundation

class RegistrationViewModel: ObservableObject {
    @Published var emailText: String = "" {
        didSet {
            debounceEmail()
        }
    }
    @Published var emailError: String?
    
    @Published var passwordText: String = "" {
        didSet {
            debouncePassword()
        }
    }
    @Published var passwordError: String?
    
    @Published var confirmPasswordText: String = "" {
        didSet {
            debounceConfirmPassword()
        }
    }
    @Published var confirmPasswordError: String?
    @Published var canProceed: Bool = false
    
    private var emailWorkItem: DispatchWorkItem?
    private var passwordWorkItem: DispatchWorkItem?
    private var confirmPasswordWorkItem: DispatchWorkItem?
    
    
    private func validateEmail() {
        if emailText.isEmpty {
            emailError = "Email field is empty"
        } else {
            emailError = nil
        }
        let emailTest = NSPredicate(format: "SELF MATCHES %@", "^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$")
        if !emailTest.evaluate(with: emailText) {
            emailError =  "Email isnt properly formated"
        } else {
            emailError = nil
        }
        
        checkErrors()
    }
    private func validatePassword() {
        if passwordText.isEmpty {
            passwordError = "Enter password"
        } else
        if passwordText.count < 8 {
            passwordError = "Password is too short"
        } else
        if passwordText.count > 20 {
            passwordError = "Password is too long"
        } else {
            passwordError = nil
        }
        let specialCharacterRegex = ".*[!@#$%^&*()_+=\\-\\[\\]{};':\"\\\\|,.<>/?]+.*"
        let specialCharTest = NSPredicate(format: "SELF MATCHES %@", specialCharacterRegex)
        
        if !specialCharTest.evaluate(with: passwordText) {
            passwordError = "Password must contain at least one special character"
        }
        
        checkErrors()
    }
    
    private func validateConfirmPassword() {
        if passwordText == confirmPasswordText {
            confirmPasswordError = nil
            print("mathes")
        } else {
            confirmPasswordError = "Passwords doesnt match"
        }
        
        checkErrors()
    }
    
    private func debouncePassword() {
        passwordWorkItem?.cancel()
        let item = DispatchWorkItem { [weak self] in
            self?.validatePassword()
        }
        passwordWorkItem = item
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: item)
    }
    
    private func debounceConfirmPassword() {
        confirmPasswordWorkItem?.cancel()
        let item = DispatchWorkItem {[weak self] in
            self?.validateConfirmPassword()
        }
        confirmPasswordWorkItem = item
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: item)
    }
    
    private func debounceEmail() {
        emailWorkItem?.cancel()
        let item = DispatchWorkItem {[weak self] in
            self?.validateEmail()
        }
        emailWorkItem = item
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: item)
    }
    
    private func checkErrors() {
        if emailError == nil && passwordError == nil && confirmPasswordError == nil {
            canProceed = false
        } else {
            canProceed = true
        }
    }
    
}
