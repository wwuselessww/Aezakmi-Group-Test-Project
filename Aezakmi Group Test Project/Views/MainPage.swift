//
//  MainPage.swift
//  Aezakmi Group Test Project
//
//  Created by Alexander Kozharin on 13.05.25.
//

import SwiftUI
import FirebaseAuth

struct MainPage:View {
    @EnvironmentObject var appVM: AppViewModel
    var body: some View {
        VStack {
            Text("\(Auth.auth().currentUser?.uid)")
            Button {
                appVM.signOut()
            } label: {
                Text("Sign out")
                    .bold()
                    .foregroundStyle(.white)
            }
            .withDefaultButtonFormatting(disabled: .constant(false))
            .padding()

        }
    }
}
#Preview {
    MainPage()
        .environmentObject(AppViewModel())
}
