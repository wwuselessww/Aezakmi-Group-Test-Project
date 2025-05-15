//
//  TextEditor.swift
//  Aezakmi Group Test Project
//
//  Created by Alexander Kozharin on 16.05.25.
//

import SwiftUI

struct TextEditor: View {
    @Binding var text: String
    @Binding var textColor: Color
    @Binding var selectedFontSize: Int
    var body: some View {
        
        VStack {
            Text("Tap on image where you want to place text")
                .bold()
                .foregroundStyle(.black)
            Picker(selection: $selectedFontSize) {
                
                Text("10").tag(10)
                Text("20").tag(20)
                Text("30").tag(30)
                Text("40").tag(40)
                
            } label: {
                Text("\(selectedFontSize)")
                    .foregroundStyle(.white)
            }
            .pickerStyle(.segmented)

            HStack {
                TextField("Enter Text", text: $text)
                    .bold()
                    .foregroundStyle(.white)
                Spacer()
                
                ColorPicker("Text Color", selection: $textColor)
                    .foregroundStyle(.white)
            }
            .padding(.horizontal)
            .withDefaultButtonFormatting(disabled: .constant(false))
        }
        .padding(.horizontal)
    }
}

#Preview {
    TextEditor(
        text: .constant("Example Text"),
        textColor: .constant(.red),
        selectedFontSize: .constant(20)
    )
}
