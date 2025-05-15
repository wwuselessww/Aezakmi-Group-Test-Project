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
    @Published var selection: UIImage?
    let cropOptions = CroppedPhotosPickerOptions(doneButtonTitle: "select", doneButtonColor: .orange)
    
    var filtersArray: [Filter] = [
        .init(name: "crystallize", filter: CIFilter.crystallize()),
        .init(name: "sepia tone", filter: CIFilter.sepiaTone()),
        .init(name: "vignette", filter: CIFilter.vignette())
    ]
    
    @Published var didTapFiltersBtn: Bool = false
    @Published var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    @Published var filterIntensity = 0.0
    
    @MainActor
    func applyProccesing() {
//        currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputScaleKey)
        }
        
        
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
            await applyProccesing()
        }
    }
    
    @MainActor
    func applyTestProccesing() {
//        currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        let intensity = 0.5
        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(intensity, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(intensity * 200, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(intensity, forKey: kCIInputScaleKey)
        }
        
        
        guard let outputImage = currentFilter.outputImage else {return}
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else {return}
        
        let uiImage = UIImage(cgImage: cgImage)
        selection = uiImage
        print("hehe")
    }
    
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        getImage()
    }
}

struct Filter: Identifiable {
    let id = UUID()
    let name: String
    let filter: CIFilter
}
