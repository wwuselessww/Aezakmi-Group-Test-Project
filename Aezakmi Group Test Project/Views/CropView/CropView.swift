//
//  CropView.swift
//  Aezakmi Group Test Project
//
//  Created by Alexander Kozharin on 15.05.25.
//

import SwiftUI
import CropViewController

struct CropView: UIViewControllerRepresentable {
    private var image: UIImage
    private var didCropToImage: ((CroppedImage) -> ())?
    private var didCropToCirclarImage: ((CroppedImage) -> ())?
    private var didCropImageToRect: ((CroppedRect) -> ())?
    private var didFinishCancelled: (Bool) -> ()
    
    private let controller: CropViewController
    
    init(image: UIImage,
         croppingStyle: CroppedPhotosPickerCroppingStyle = .default,
         croppingOptions: CroppedPhotosPickerOptions = .init(),
         didCropToImage: ((CroppedImage) -> Void)? = nil,
         didCropToCirclarImage: ((CroppedImage) -> Void)? = nil,
         didCropImageToRect: ((CroppedRect) -> Void)? = nil,
         didFinishCancelled: @escaping (Bool) -> Void) {
        
        self.image = image
        self.didCropToImage = didCropToImage
        self.didCropToCirclarImage = didCropToCirclarImage
        self.didCropImageToRect = didCropImageToRect
        self.didFinishCancelled = didFinishCancelled
        
        self.controller = CropViewController(croppingStyle: croppingStyle, image: image)
        
        self.controller.setCroppingOptions(croppingOptions)
        
        
    }
    
    class Coordinator: NSObject, CropViewControllerDelegate {
        let parent: CropView
        
        init(parent: CropView) {
            self.parent = parent
        }
        
        func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
            let croppedImage = CroppedImage(image: image, rect: cropRect, angle: angle)
            parent.didCropToImage?(croppedImage)
        }
        
        func cropViewController(_ cropViewController: CropViewController, didCropToCircularImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
            let croppedImage = CroppedImage(image: image, rect: cropRect, angle: angle)
            parent.didCropToImage?(croppedImage)
        }
        
        func cropViewController(_ cropViewController: CropViewController, didCropImageToRect cropRect: CGRect, angle: Int) {
            let cropperRect = CroppedRect(rect: cropRect, angle: angle)
            parent.didCropImageToRect?(cropperRect)
        }
        
        func cropViewController(_ cropViewController: CropViewController, didFinishCancelled cancelled: Bool) {
            parent.didFinishCancelled(cancelled)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}
