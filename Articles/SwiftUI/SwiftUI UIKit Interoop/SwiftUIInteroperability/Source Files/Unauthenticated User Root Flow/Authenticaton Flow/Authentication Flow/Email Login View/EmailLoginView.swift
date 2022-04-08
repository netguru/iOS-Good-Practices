//
//  EmailLoginView.swift
//  SwiftUI Interoperability
//

import SwiftUI

struct EmailLoginView: View {

    @StateObject var viewModel: DefaultEmailLoginViewModel
    @FocusState private var focusedField: String?

    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 30) {
                Spacer()
                Button {
                    resignFirstResponder()
                    viewModel.logIn()
                } label: {
                    Text("LOG IN").hollowedButtonText()
                }
                .disabled(!canSubmit)
                Button {
                    resignFirstResponder()
                    viewModel.navigateToRegistration()
                } label: {
                    Text("SIGN UP").font(.footnote)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            VStack(alignment: .center, spacing: 10) {
                TextInput(
                    value: $viewModel.email,
                    focusedField: _focusedField,
                    error: viewModel.currentAuthenticationError,
                    prompt: Field.email.prompt,
                    fieldName: Field.email.rawValue,
                    keyboardType: .emailAddress
                )
                SecureTextInput(
                    value: $viewModel.password,
                    focusedField: _focusedField,
                    error: viewModel.currentAuthenticationError,
                    prompt: Field.password.prompt,
                    fieldName: Field.password.rawValue,
                    keyboardType: .default
                )
            }
            .padding()
        }
        .onAppear {
            setFocusDelayed(to: .email)
        }
    }
}

private extension EmailLoginView {

    /// Currently focused field.
    enum Field: String {
        case email, password

        var prompt: String {
            switch self {
            case .email:
                return "Enter email"
            case .password:
                return "Enter password"
            }
        }

        var keyboardType: UIKeyboardType {
            switch self {
            case .email:
                return .emailAddress
            case .password:
                return .default
            }
        }

        var isSecure: Bool {
            switch self {
            case .email:
                return false
            case .password:
                return true
            }
        }
    }

    var canSubmit: Bool {
        viewModel.currentAuthenticationError == nil && viewModel.email.count > 3 && viewModel.password.count > 3
    }

    func resignFirstResponder() {
        focusedField = nil
    }

    func setFocusDelayed(to field: Field) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.focusedField = field.rawValue
        }
    }
}
