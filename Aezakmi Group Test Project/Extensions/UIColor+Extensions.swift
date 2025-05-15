//
//  UIColor+Extensions.swift
//  Aezakmi Group Test Project
//
//  Created by Alexander Kozharin on 16.05.25.
//
import SwiftUI
import UIKit

extension Color {
    func toUIColor() -> UIColor {
        let uiColor: UIColor

        // Convert using UIColor initializer
        if #available(iOS 14.0, *) {
            uiColor = UIColor(self)
        } else {
            // Fallback for earlier versions (approximate using RGB components)
            let components = self.cgColor?.components ?? [0, 0, 0, 1]
            uiColor = UIColor(red: components[0], green: components[1], blue: components[2], alpha: components.count > 3 ? components[3] : 1)
        }

        return uiColor
    }
}
