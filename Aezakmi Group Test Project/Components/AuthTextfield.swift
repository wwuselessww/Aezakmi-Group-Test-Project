//
//  AuthTextfield.swift
//  Aezakmi Group Test Project
//
//  Created by Alexander Kozharin on 13.05.25.
//

import SwiftUI

struct AuthTextfield: View {
    @Binding var text: String
    @Binding var errorText: String?
    var placeholder: String
    var title: String
    var isSecure: Bool
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .foregroundStyle(errorText != nil ? .red: .black)
            Group {
                if isSecure {
                    SecureField(placeholder, text: $text)
                } else {
                    TextField(placeholder, text: $text)
                }
            }
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(lineWidth: 2)
                        .foregroundStyle(errorText != nil ? .red: .gray)
                }
                .frame(minWidth: 200, maxWidth: 360, minHeight: 40, maxHeight: 48)
//            if let error = errorText {
//                Text(error)
//                    .foregroundStyle(.red)
//            }
            Text(errorText ?? "kek")
                .foregroundStyle(errorText == nil ? .clear : .red)
        }
    }
}

#Preview {
    AuthTextfield(text: .constant("sss"), errorText: .constant(nil), placeholder: "sdsad", title: "sdasdad", isSecure: false)
}
