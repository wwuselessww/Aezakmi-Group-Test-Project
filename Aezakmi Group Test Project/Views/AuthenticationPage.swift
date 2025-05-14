//
//  RegistrationPage.swift
//  Aezakmi Group Test Project
//
//  Created by Alexander Kozharin on 13.05.25.
//

import SwiftUI
import FirebaseAuth
import GoogleSignInSwift
import GoogleSignIn

struct AuthenticationPage: View {
    @EnvironmentObject var appVM: AppViewModel
    @StateObject var vm: AuthenticationViewModel = AuthenticationViewModel()
    
    var body: some View {
        VStack {
             Spacer()
             Text ("Aezami Group Photos")
                 .font(.system(size: 36))
            Text(appVM.loginError ?? "none")
                .foregroundStyle(appVM.loginError != nil ? .red : .clear)
                 .padding(.bottom, 30)
             Spacer()
             AuthTextfield(text: $vm.loginText, errorText: $vm.loginError, placeholder: "Enter email here", title: "Email", isSecure: false)
                 .padding(.bottom, 10)
             AuthTextfield(text: $vm.passwordText, errorText: $vm.passwordError, placeholder: "Enter password here", title: "Password", isSecure: true)
             Button("Log in") {
                 appVM.login(email: vm.loginText, password: vm.passwordText)
             }
             .foregroundStyle(.white)
             .withDefaultButtonFormatting(disabled: $vm.canProceed)
            
            Button(action: {
                vm.handleSignInGoogle()
            }, label: {
                HStack {
                    Image(.googlelogo)
                        .resizable()
                        .scaledToFit()
                    Text("Continue with google")
                        .bold()
                        .foregroundStyle(.white)
                        
                }
            })
            .foregroundStyle(.white)
            .withDefaultButtonFormatting(disabled: .constant(false))

            
             .padding(.top, 20)
             NavigationLink {
                 RegistrationPage()
                     .environmentObject(appVM)
             } label: {
                 HStack(spacing: 1.5) {
                     Text("or ")
                     Text("sign up")
                         .overlay {
                             Rectangle()
                                 .frame(height: 1.5)
                                 .offset(y:12)
                         }
                     
                     Text(" with email")
                 }
                 
                 .foregroundStyle(.black)
             }
             Spacer()

         }
        .onAppear(perform: {
            appVM.loginError = nil
        })

         .padding(.horizontal)
    }
}
#Preview {
    NavigationStack {
        AuthenticationPage()
            .environmentObject(AppViewModel())
    }
}
