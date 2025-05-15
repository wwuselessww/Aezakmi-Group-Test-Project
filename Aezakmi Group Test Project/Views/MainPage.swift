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
            Spacer()
            Group {
                if let selection = vm.selection {
                    Image(uiImage: selection)
                        .resizable()
                        .scaledToFit()
                        .frame(minWidth: 200, maxWidth: .infinity)
                } else {
                    VStack {
                        Image(systemName: "photo.artframe")
                            .resizable()
                            .scaledToFit()
                            .frame(minWidth: 100, maxWidth: 200)
                        Text("Image isnt selected")
                    }
                        
                }
            }
            
            Spacer()
            HStack(spacing: 30) {
                PhotoEditButton(systemImage: "pencil", title: "draw", disable: .constant(false)) {
                    print("draw")
                }
                PhotoEditButton(systemImage: "camera.filters", title: "filtes", disable: .constant(false)) {
                    print("filtes")
                }
                PhotoEditButton(systemImage: "square.and.arrow.down", title: "save", disable: .constant(false)) {
                    print("save")
                }
                PhotoEditButton(systemImage: "square.and.arrow.up", title: "share", disable: .constant(false)) {
                    print("share")
                }
            }
            CroppedPhotosPicker(style: .default, options: vm.cropOptions, selection: $vm.selection) { rect in
                print("did Crop to rect \(rect)")
            } didCancel: {
                print("did cancel")
            } label: {
                Text("Pick and crop Image")
                    .foregroundStyle(.white)
                    .bold()
                    .withDefaultButtonFormatting(disabled: .constant(false))
                    
            }

            
        }
        .padding()
    }
}
#Preview {
    MainPage()
        .environmentObject(AppViewModel())
}
