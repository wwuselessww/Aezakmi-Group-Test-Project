//
//  BrandButtonModifier.swift
//  Aezakmi Group Test Project
//
//  Created by Alexander Kozharin on 13.05.25.
//

import SwiftUI

struct DefaultButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(minWidth: 40, maxWidth: .infinity, minHeight: 40, maxHeight: 50)
            .background {
                RoundedRectangle(cornerRadius: 5)
            }
    }
}

extension View {
    func withDefaultButtonFormatting() -> some View {
        modifier(DefaultButtonModifier())
    }
}


#Preview(body: {
    Button {
        print("s")
    } label: {
        Text("sss")
            .foregroundStyle(.white)
    }
    .withDefaultButtonFormatting()
    .padding(.horizontal)

})
