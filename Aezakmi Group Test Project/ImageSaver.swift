//
//  ImageSaver.swift
//  Aezakmi Group Test Project
//
//  Created by Alexander Kozharin on 15.05.25.
//

import UIKit

class ImageSaver: NSObject {
//    static let shared: ImageSaver = ImageSaver()
    var isError: Bool = false
    
    func writeToPhotoAlbum(image: UIImage) -> ImageSavingFeedback{
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
        if !isError {
            return ImageSavingFeedback(title: "Image Saved", isError: false)
        } else {
            return ImageSavingFeedback(title: "Error with saving this image", isError: true)
        }
    }
    
    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if error != nil {
            print(error?.localizedDescription)
            isError = true
        } else {
            isError = false
        }
    }
}

struct ImageSavingFeedback {
    var title: String
    var isError: Bool
}
