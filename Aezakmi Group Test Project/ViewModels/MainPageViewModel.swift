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
import PencilKit
import CoreGraphics

class MainPageViewModel: ObservableObject {
    
    var filtersArray: [Filter] = [
        .init(name: "crystallize", filter: CIFilter.crystallize()),
        .init(name: "sepia tone", filter: CIFilter.sepiaTone()),
        .init(name: "vignette", filter: CIFilter.vignette())
    ]
    let cropOptions = CroppedPhotosPickerOptions(doneButtonTitle: "select", doneButtonColor: .orange)
    
    @Published var selection: UIImage?
    @Published var userFeedbackText: ImageSavingFeedback?
    @Published var didTapFiltersBtn: Bool = false
    @Published var didTapAddTextBtn: Bool = false
    @Published var didTapDrawBtn: Bool = false
    @Published var canvasView = PKCanvasView()
    @Published var currentFilter: CIFilter = CIFilter.sepiaTone()
    @Published var filterIntensity = 0.0
    @Published var textLocation: CGPoint = .zero
    
    @Published var text: String = ""
    @Published var textColor: Color = .red
    @Published var textFontSize: Int = 10
    let context = CIContext()
    
    @MainActor
    func applyProccesing() {
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
    
    func saveImage() {
        guard let imageForSaving = selection else {return}
        let imageSaver = ImageSaver()
        withAnimation(.easeInOut) {
            userFeedbackText = imageSaver.writeToPhotoAlbum(image: imageForSaving)
            let item = DispatchWorkItem { [self] in
                withAnimation {
                    userFeedbackText = nil
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: item)
        }
    }
    @MainActor
    func draw() {
        guard let baseImage = selection else { return }

        let size = baseImage.size
        UIGraphicsBeginImageContextWithOptions(size, false, baseImage.scale)

        // Draw original image
        baseImage.draw(in: CGRect(origin: .zero, size: size))

        // Draw the drawing
        let drawingImage = canvasView.drawing.image(from: CGRect(origin: .zero, size: size), scale: baseImage.scale)
        drawingImage.draw(in: CGRect(origin: .zero, size: size))

        let combinedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        if let combinedImage {
                selection = combinedImage
        }
    }
    @MainActor
    func addTextToImage(viewSize: CGSize) {
        guard let baseImage = selection else { return }

        let renderer = UIGraphicsImageRenderer(size: baseImage.size)
        let image = renderer.image { ctx in
            baseImage.draw(in: CGRect(origin: .zero, size: baseImage.size))
            let scaleX = baseImage.size.width / viewSize.width
            let scaleY = baseImage.size.height / viewSize.height
            let imagePoint = CGPoint(x: textLocation.x * scaleX, y: textLocation.y * scaleY)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center

            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: CGFloat(textFontSize)),
                .paragraphStyle: paragraphStyle,
                .foregroundColor: textColor.toUIColor()
            ]

            let string = text
            let attributedString = NSAttributedString(string: string, attributes: attrs)

            attributedString.draw(
                with: CGRect(origin: imagePoint, size: CGSize(width: 600, height: 300)),
                options: .usesLineFragmentOrigin,
                context: nil
            )
        }

        Task {
            selection = image
        }
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
