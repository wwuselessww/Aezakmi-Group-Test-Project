//
//  BrandButtonModifier.swift
//  Aezakmi Group Test Project
//
//  Created by Alexander Kozharin on 13.05.25.
//

import SwiftUI

struct DefaultButtonModifier: ViewModifier {
    @Binding var disabled: Bool
    func body(content: Content) -> some View {
        content
            .frame(minWidth: 40, maxWidth: .infinity, minHeight: 40, maxHeight: 50)
            .disabled(disabled)
            .background {
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(disabled ? .gray : .black)
            }
    }
}

extension View {
    func withDefaultButtonFormatting(disabled: Binding<Bool>) -> some View {
        modifier(DefaultButtonModifier(disabled: disabled))
    }
}


#Preview(body: {
    Button {
        print("s")
    } label: {
        Text("sss")
            .foregroundStyle(.white)
    }
    .withDefaultButtonFormatting(disabled: .constant(true ))
    .padding(.horizontal)

})
