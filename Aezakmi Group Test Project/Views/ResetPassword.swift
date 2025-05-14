//
//  ResetPassword.swift
//  Aezakmi Group Test Project
//
//  Created by Alexander Kozharin on 14.05.25.
//

import SwiftUI

struct ResetPassword: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var appVM: AppViewModel
    @StateObject var vm = ResetPasswordViewModel()
    var body: some View {
        VStack {
            AuthTextfield(text: $vm.emailText, errorText: $vm.emailError, placeholder: "Where to send your password", title: "Email", isSecure: false)
                .padding(.top, 20)
            Button {
                appVM.resetPassword(email: vm.emailText)
                dismiss()
            } label: {
                Text("Send Email")
                    .foregroundStyle(.white)
            }
            .withDefaultButtonFormatting(disabled: $vm.disableBtn)

            Spacer()
        }
        .padding(.horizontal)
    }
}
#Preview {
    ResetPassword()
        .environmentObject(AppViewModel())
}
