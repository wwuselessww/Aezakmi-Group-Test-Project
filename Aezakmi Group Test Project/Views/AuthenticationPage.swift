//
//  RegistrationPage.swift
//  Aezakmi Group Test Project
//
//  Created by Alexander Kozharin on 13.05.25.
//

import SwiftUI

struct AuthenticationPage: View {
    
    @ObservedObject var vm: RegistrationViewModel = RegistrationViewModel()
    
    var body: some View {
        VStack {
            Spacer()
            Text ("Aezami Group Photos")
                .font(.system(size: 36))
                .padding(.bottom, 30)
            Spacer()
            AuthTextfield(text: $vm.loginText, errorText: $vm.loginError, placeholder: "Enter email here", title: "Email", isSecure: false)
                .padding(.bottom, 10)
            AuthTextfield(text: $vm.passwordText, errorText: $vm.passwordError, placeholder: "Enter password here", title: "Password", isSecure: true)
            Button {
                print("login")
            } label: {
                Text("Login")
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
            }
            .withDefaultButtonFormatting()
            .padding(.top, 20)
            
            Button {
                print("google")
            } label: {
                Text("Google")
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
            }
            .withDefaultButtonFormatting()
            NavigationLink {
                RegistrationPage()
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
        .padding(.horizontal)
    }
}
#Preview {
    NavigationStack {
        AuthenticationPage()
    }
}
