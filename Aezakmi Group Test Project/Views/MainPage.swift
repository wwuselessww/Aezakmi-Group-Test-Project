//
//  MainPage.swift
//  Aezakmi Group Test Project
//
//  Created by Alexander Kozharin on 13.05.25.
//

import SwiftUI
import FirebaseAuth
import PhotosUI

struct MainPage:View {
    @EnvironmentObject var appVM: AppViewModel
    @StateObject var vm = MainPageViewModel()
    
    var body: some View {
        VStack {
//            Text("\(Auth.auth().currentUser?.uid)")
//            Button {
//                appVM.signOut()
//            } label: {
//                Text("Sign out")
//                    .bold()
//                    .foregroundStyle(.white)
//            }
//            .withDefaultButtonFormatting(disabled: .constant(false))
//            .padding()
            if let image = vm.image {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(minWidth: 50, maxWidth: 300, minHeight: 50, maxHeight: 300)
            } else {
                Image(systemName: "photo.artframe")
                    .resizable()
                    .scaledToFit()
                    .frame(minWidth: 50, maxWidth: 100)
            }
            PhotosPicker("Select Photo For Edit", selection: $vm.selectedPhoto, matching: .images)
                .foregroundStyle(.white)
                .bold()
                .withDefaultButtonFormatting(disabled: .constant(false))

        }
        .padding(.horizontal)
        .onChange(of: vm.selectedPhoto) { oldValue, newValue in
            Task {
                do {
                    let loaded = try await vm.selectedPhoto?.loadTransferable(type: Image.self)
                        vm.image = loaded
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
#Preview {
    MainPage()
        .environmentObject(AppViewModel())
}
