//
//  CroppedPhotosPicker.swift
//  Aezakmi Group Test Project
//
//  Created by Alexander Kozharin on 15.05.25.
//

import SwiftUI
import PhotosUI
import CropViewController

struct CroppedPhotosPicker<Label: View>: View {
    struct SelectedImage: Identifiable {
        var id = UUID().uuidString
        var image: UIImage
    }
    
    private var style: CroppedPhotosPickerCroppingStyle
    private var options: CroppedPhotosPickerOptions
    @Binding private var selection: UIImage?
    private var didCrop: ((CroppedRect) -> ())?
    private var didCancel: (() -> ())?
    @ViewBuilder private var label: () -> Label
    
    init(style: CroppedPhotosPickerCroppingStyle = .default,
         options: CroppedPhotosPickerOptions = .init(),
         selection: Binding<UIImage?>,
         didCrop: ((CroppedRect) -> Void)? = nil,
         didCancel: (() -> Void)? = nil,
         @ViewBuilder label: @escaping () -> Label) {
        self.style = style
        self.options = options
        self._selection = selection
        self.didCrop = didCrop
        self.didCancel = didCancel
        self.label = label
    }
    
    @State var selectedItem: PhotosPickerItem?
    @State var selectedImage: SelectedImage?
    var body: some View {
        PhotosPicker(selection: $selectedItem, matching: .images) {
            label()
        }
        .onChange(of: selectedItem) { _, newValue in
            if let item = newValue {
                Task {
                    let uiImage = await item.convert()
                    guard let uiImage else {return}
                    selectedImage = SelectedImage(image: uiImage)
                }
            }
        }
        .sheet(item: $selectedImage) { selectedImage in
            CropView(image: selectedImage.image, croppingStyle: style, croppingOptions: options) { image in
                self.selectedImage = nil
                self.selectedItem = nil
                self.selection = image.image
                self.didCrop?(CroppedRect(rect: image.rect, angle: image.angle))
                
            } didCropToCirclarImage: { image in
                self.selectedImage = nil
                self.selectedItem = nil
                self.selection = image.image
                self.didCrop?(CroppedRect(rect: image.rect, angle: image.angle))
            } didCropImageToRect: { _ in
                
            } didFinishCancelled: { _ in
                self.selectedImage = nil
                self.selectedItem = nil
                didCancel?()
            }
            .ignoresSafeArea()

        }
    }
}

//#Preview {
//    CroppedPhotosPicker()
//}
