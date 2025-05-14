//
//  RegistrationViewModel.swift
//  Aezakmi Group Test Project
//
//  Created by Alexander Kozharin on 13.05.25.
//

import SwiftUI
import FirebaseAuth
import Firebase
import GoogleSignIn

class AuthenticationViewModel: ObservableObject {
    @Published var loginText: String = "" {
        didSet {
            debounceLoginValidation()
        }
    }
    @Published var loginError: String? = ""
    
    @Published var passwordText: String = "" {
        didSet {
            debouncePasswordValidation()
        }
    }
    @Published var passwordError: String? = ""
    @Published var canProceed: Bool = true
    
    private var passwordValidationWorkItem: DispatchWorkItem?
    private var loginValidationWorkItem: DispatchWorkItem?
    
    private func validateLogin() {
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
        if loginError == nil && passwordError == nil {
            canProceed = false
        } else {
            canProceed = true
        }
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
        
        if loginError == nil && passwordError == nil {
            canProceed = false
        } else {
            canProceed = true
        }
    }
    
    func handleSignInGoogle() {
        
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let rootVC = scene.windows.first?.rootViewController else {
            print("no vc")
            return
        }
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            return
        }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        
        GIDSignIn.sharedInstance.signIn(
            withPresenting: rootVC) { signInResult, error in
                guard let result = signInResult else {
                    // Inspect error
                    return
                }
                // If sign in succeeded, display the app's main content View.
                guard let user = signInResult?.user, let idToken = user.idToken else {return}
                let accessToken =  user.accessToken
                let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: accessToken.tokenString)
                print(result.user.profile?.name)
                Auth.auth().signIn(with: credential) {result, error in
                    if error == nil {
                        print("google\n \(error?.localizedDescription)")
                    }
                }
            }
    }
    
    private func debounceLoginValidation() {
        loginValidationWorkItem?.cancel()
        let item = DispatchWorkItem { [weak self] in
            self?.validateLogin()
        }
        loginValidationWorkItem = item
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: item)
    }
    
    private func debouncePasswordValidation() {
        passwordValidationWorkItem?.cancel()
        let item = DispatchWorkItem {[weak self] in
            self?.validatePassword()
        }
        passwordValidationWorkItem = item
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: item)
    }
}
