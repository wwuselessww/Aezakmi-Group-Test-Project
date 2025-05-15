//
//  MainPageViewModel.swift
//  Aezakmi Group Test Project
//
//  Created by Alexander Kozharin on 15.05.25.
//

import SwiftUI
import PhotosUI

class MainPageViewModel: ObservableObject {
//    @Published var selectedPhoto: PhotosPickerItem?
//    @Published var image: Image?
    @Published var selection: UIImage?
    let cropOptions = CroppedPhotosPickerOptions(doneButtonTitle: "select", doneButtonColor: .orange)
}
