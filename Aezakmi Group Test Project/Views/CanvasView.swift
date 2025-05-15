//
//  CanvasView.swift
//  Aezakmi Group Test Project
//
//  Created by Alexander Kozharin on 15.05.25.
//

import Foundation
import PencilKit
import SwiftUI

struct CanvasView: UIViewRepresentable {
    @Binding var canvasView: PKCanvasView
    let backgroundImage: UIImage?

    func makeUIView(context: Context) -> PKCanvasView {
        canvasView.drawingPolicy = .anyInput
        canvasView.isOpaque = false
        canvasView.backgroundColor = .clear
        if let image = backgroundImage {
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.clipsToBounds = true

            canvasView.insertSubview(imageView, at: 0)

            NSLayoutConstraint.activate([
                imageView.centerXAnchor.constraint(equalTo: canvasView.centerXAnchor),
                imageView.centerYAnchor.constraint(equalTo: canvasView.centerYAnchor),
                imageView.widthAnchor.constraint(lessThanOrEqualTo: canvasView.widthAnchor),
                imageView.heightAnchor.constraint(lessThanOrEqualTo: canvasView.heightAnchor),
                imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: image.size.width / image.size.height)
            ])
        }
        
        
        return canvasView
    }

    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        // Update view if needed
    }
}


//#Preview(body: {
//    CanvasView(canvasView: <#Binding<PKCanvasView>#>, backgroundImage: <#UIImage?#>) 
//})
