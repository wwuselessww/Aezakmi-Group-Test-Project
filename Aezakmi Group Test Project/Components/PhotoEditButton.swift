//
//  PhotoEditButton.swift
//  Aezakmi Group Test Project
//
//  Created by Alexander Kozharin on 15.05.25.
//

import SwiftUI

struct PhotoEditButton: View {
    var systemImage: String
    var title: String
    @Binding var disable: Bool
    var action: (() -> Void)?
    var body: some View {
        Button {
            action?()
        } label: {
            VStack {
                Image(systemName: systemImage)
                    .foregroundStyle(.white)
                    .withDefaultButtonFormatting(disabled: $disable)
                    .frame(width: 40, height: 40)
                Text(title)
                    .foregroundStyle(.black)
                    .bold()

            }
        }

    }
}

#Preview {
    PhotoEditButton(systemImage: "pencil", title: "draw", disable: .constant(false)) {
        print("jjjjjj")
    }
}
