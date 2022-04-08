//
//  SecureTextInput.swift
//  SwiftUI Interoperability
//

import SwiftUI

struct SecureTextInput: View {

    @Binding var value: String
    @FocusState var focusedField: String?
    let error: LocalizableError?
    let prompt: String
    let fieldName: String
    let keyboardType: UIKeyboardType

    var body: some View {
        VStack {
            SecureField(
                prompt,
                text: $value
            )
            .onSubmit {
                focusedField = nil
            }
            .focused($focusedField, equals: fieldName)
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .keyboardType(keyboardType)
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
