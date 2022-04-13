//
//  SecureTextInput.swift
//  SwiftUI Interoperability
//

import SwiftUI

struct SecureTextInput: View {

    let configuration: TextInputConfiguration
    @Binding var value: String
    @FocusState var focusedField: String?
    let error: LocalizableError?

    var body: some View {
        VStack {
            SecureField(
                configuration.prompt,
                text: $value
            )
            .onSubmit {
                focusedField = nil
            }
            .focused($focusedField, equals: configuration.name)
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .keyboardType(configuration.type.keyboardType)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(Color.blue, lineWidth: 2)
            )
            Text(error?.localizedDescription ?? " ")
                .font(.caption)
                .foregroundColor(.red)
        }
        .padding()
    }
}
