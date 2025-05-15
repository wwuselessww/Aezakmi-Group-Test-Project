//
//  PhotosPickerItem+Extensions.swift
//  Aezakmi Group Test Project
//
//  Created by Alexander Kozharin on 15.05.25.
//

import SwiftUI
import PhotosUI

extension PhotosPickerItem {
    @MainActor
    func convert() async -> UIImage? {
        do {
            if let data = try await self.loadTransferable(type: Data.self) {
                if let uiImage = UIImage(data: data) {
                    return uiImage
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}
