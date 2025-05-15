//
//  MainPageViewModel.swift
//  Aezakmi Group Test Project
//
//  Created by Alexander Kozharin on 15.05.25.
//

import SwiftUI
import PhotosUI
import CoreImage
import CoreImage.CIFilterBuiltins

class MainPageViewModel: ObservableObject {
//    @Published var selectedPhoto: PhotosPickerItem?
//    @Published var image: Image?
    @Published var selection: UIImage?
    let cropOptions = CroppedPhotosPickerOptions(doneButtonTitle: "select", doneButtonColor: .orange)
    
    @Published var didTapFiltersBtn: Bool = false
    @Published var currentFilter = CIFilter.sepiaTone()
    let context = CIContext()
    let filterIntensity = 0.5
    
    
    func applyProccesing() {
        currentFilter.intensity = Float(filterIntensity)
        guard let outputImage = currentFilter.outputImage else {return}
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else {return}
        
        let uiImage = UIImage(cgImage: cgImage)
        selection = uiImage
        print("hehe")
    }
    
    func getImage() {
        Task {
            guard let selectedImage = selection else {return}
            let beginImage = CIImage(image: selectedImage)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            applyProccesing()
        }
    }
}
