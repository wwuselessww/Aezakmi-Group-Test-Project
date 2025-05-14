//
//  ResetPasswordViewModel.swift
//  Aezakmi Group Test Project
//
//  Created by Alexander Kozharin on 14.05.25.
//

import SwiftUI

class ResetPasswordViewModel: ObservableObject {
    @Published var emailText: String = "" {
        didSet {
            self.debounceEmailText()
        }
    }
    @Published var emailError: String? = ""
    @Published var disableBtn: Bool = true
    private var emailTextWorkItem: DispatchWorkItem?
    
    
    private func debounceEmailText() {
        emailTextWorkItem?.cancel()
        let item = DispatchWorkItem {[weak self] in
            self?.validateEmail()
        }
        emailTextWorkItem = item
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: item)
    }
    
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
        if emailError == nil {
            disableBtn = false
        } else {
            disableBtn = true
        }
    }
}
