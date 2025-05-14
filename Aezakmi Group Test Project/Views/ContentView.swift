//
//  ContentView.swift
//  Aezakmi Group Test Project
//
//  Created by Alexander Kozharin on 13.05.25.
//

import SwiftUI
import FirebaseAuth
import GoogleSignIn

struct ContentView: View {
    @ObservedObject var vm = AppViewModel()
    var body: some View {
        ZStack {
            if vm.isUserLoggedIn {
                MainPage()
                    .environmentObject(vm)
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
            } else {
                AuthenticationPage()
                    .environmentObject(vm)
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
            }
        }
        .onOpenURL(perform: { url in
            GIDSignIn.sharedInstance.handle(url)
        })
        .animation(.easeInOut(duration: 0.3), value: vm.isUserLoggedIn)
    }
}

#Preview {
    ContentView()
}
