//
//  CanvasView.swift
//  Aezakmi Group Test Project
//
//  Created by Alexander Kozharin on 15.05.25.
//

import SwiftUI
import PencilKit

struct CanvasView: UIViewRepresentable {
    @Binding var canvasView: PKCanvasView

    var backgroundImage: UIImage?
    func makeUIView(context: Context) -> PKCanvasView {

        canvasView.delegate = context.coordinator
        canvasView.tool = PKInkingTool(.pen, color: .blue, width: 30)
        canvasView.drawingPolicy = .anyInput
        canvasView.backgroundColor = .gray.withAlphaComponent(0.1)
        
        guard let initialContentSize = backgroundImage?.size else {
            fatalError("**ERROR WITH BACKGROUNDIMAGE SIZE")
        }
        canvasView.contentSize = initialContentSize
        canvasView.minimumZoomScale = .zero
        canvasView.maximumZoomScale = 10
        canvasView.zoomScale = 1

        let image = backgroundImage
            
            let imageView = UIImageView(image: image)
            imageView.tintColor = .gray.withAlphaComponent(0.2)
            imageView.contentMode = .redraw
            imageView.clipsToBounds = true
        
            canvasView.subviews.first?.addSubview(imageView)
            canvasView.subviews.first?.sendSubviewToBack(imageView)
        return canvasView
    }

    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        print("hehe")
    }
}

extension CanvasView {
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, PKCanvasViewDelegate {
        var parent: CanvasView

        init(_ parent: CanvasView) {
            self.parent = parent
        }
    }
}
