//
//  AuthPage.swift
//  Aezakmi Group Test Project
//
//  Created by Alexander Kozharin on 13.05.25.
//

import SwiftUI

struct RegistrationPage: View {
    @EnvironmentObject var appVM: AppViewModel
    @StateObject var vm = RegistrationViewModel()
    
    var body: some View {
        VStack {
            Spacer()
            Text ("Aezami Group Photos")
            
                .font(.system(size: 36))
            Text(appVM.loginError ?? "none")
                .foregroundStyle(appVM.loginError != nil ? .red : .clear)
                .padding(.bottom, 30)
            
            Spacer()
            AuthTextfield(text: $vm.emailText, errorText: $vm.emailError, placeholder: "Enter email here", title: "Email", isSecure: false)
                .padding(.bottom, 10)
            AuthTextfield(text: $vm.passwordText, errorText: $vm.passwordError, placeholder: "Enter password here", title: "Password", isSecure: true)
                .padding(.bottom, 10)
            AuthTextfield(text: $vm.confirmPasswordText, errorText: $vm.confirmPasswordError, placeholder: "Confirm password here", title: "Confirm Password", isSecure: true)
            Button("Registration") {
                appVM.register(email: vm.emailText, password: vm.passwordText)
            }
//            .disabled(vm.canProceed)
            .foregroundStyle(.white)
            .withDefaultButtonFormatting(disabled: $vm.canProceed)
            .padding(.top, 20)
            Spacer()

        }
        .padding(.horizontal)
        .onAppear(perform: {
            appVM.loginError = nil
        })
    }
    
}
#Preview {
    RegistrationPage()
        .environmentObject(AppViewModel())
}

