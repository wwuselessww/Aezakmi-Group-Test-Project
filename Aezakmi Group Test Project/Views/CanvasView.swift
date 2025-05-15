//
//  CanvasView.swift
//  Aezakmi Group Test Project
//
//  Created by Alexander Kozharin on 15.05.25.
//


//import PencilKit
//import SwiftUI
//
//struct CanvasView: UIViewRepresentable {
//    @Binding var canvasView: PKCanvasView
//    var backgroundImage: UIImage?
//
//
//    func makeUIView(context: Context) -> PKCanvasView {
//        canvasView.drawingPolicy = .anyInput
//        canvasView.isOpaque = false
//        canvasView.backgroundColor = .clear
//
//        // Add the background image
//        if let image = backgroundImage {
//            let imageView = UIImageView(image: image)
//            imageView.contentMode = .scaleAspectFit
//            imageView.translatesAutoresizingMaskIntoConstraints = false
//            imageView.clipsToBounds = true
//            canvasView.insertSubview(imageView, at: 0)
//
//            NSLayoutConstraint.activate([
//                imageView.leadingAnchor.constraint(equalTo: canvasView.leadingAnchor),
//                imageView.trailingAnchor.constraint(equalTo: canvasView.trailingAnchor),
//                imageView.topAnchor.constraint(equalTo: canvasView.topAnchor),
//                imageView.bottomAnchor.constraint(equalTo: canvasView.bottomAnchor)
//            ])
//        }
//
//        // Show the PencilKit tool picker
//        let toolPicker = PKToolPicker()
//        toolPicker.setVisible(true, forFirstResponder: canvasView)
//        toolPicker.addObserver(canvasView)
//
//        DispatchQueue.main.async {
//            canvasView.becomeFirstResponder()
//        }
//
//        return canvasView
//    }
//
//    func updateUIView(_ uiView: PKCanvasView, context: Context) {
//        // No need to update the view for now
//    }
//}


import SwiftUI
import PencilKit

struct CanvasView: UIViewRepresentable {
    @Binding var canvasView: PKCanvasView
    var backgroundImage: UIImage?
    func makeUIView(context: Context) -> PKCanvasView {
//        let canvasView = PKCanvasView()
        canvasView.delegate = context.coordinator
        canvasView.tool = PKInkingTool(.pen, color: .blue, width: 30)
        canvasView.drawingPolicy = .anyInput

        canvasView.backgroundColor = .gray.withAlphaComponent(0.1)
//
//        let firstPoint: PKStrokePoint = .init(
//            location: CGPoint(x: 100, y: 200),
//            timeOffset: 0,
//            size: .init(width: 20, height: 20),
//            opacity: 0.8, force: 10, azimuth: 1, altitude: 5)
//        let secondPoint: PKStrokePoint = .init(
//            location: CGPoint(x: 400, y: 500),
//            timeOffset: 10,
//            size: .init(width: 20, height: 20),
//            opacity: 0.8, force: 10, azimuth: 0, altitude: 10)
//        let stroke = PKStroke(ink: .init(.fountainPen, color: .systemPink), path: .init(controlPoints: [firstPoint, secondPoint], creationDate: Date()))
//
//        canvasView.drawing.append(PKDrawing(strokes: [stroke]))
        guard let initialContentSize = backgroundImage?.size else {
            fatalError("**ERROR WITH BACKGROUNDIMAGE SIZE")
        }
//        let initialContentSize = CGSize(width: 1000, height: 2000)
        canvasView.contentSize = initialContentSize

        canvasView.minimumZoomScale = .zero
        canvasView.maximumZoomScale = 10
        canvasView.zoomScale = 1
        
        let configuration = UIImage.SymbolConfiguration(pointSize: 40)
//            let image = UIImage(systemName: "grid", withConfiguration: configuration)?.resizableImage(withCapInsets: .zero, resizingMode: .tile)
        let image = backgroundImage
            
            let imageView = UIImageView(image: image)
            imageView.tintColor = .gray.withAlphaComponent(0.2)
            imageView.contentMode = .redraw
            imageView.clipsToBounds = true
//            imageView.frame = CGRect(origin: .zero, size: initialContentSize)
        imageView.frame = CGRect(x: -300, y: -300, width: initialContentSize.width, height: initialContentSize.height)

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
