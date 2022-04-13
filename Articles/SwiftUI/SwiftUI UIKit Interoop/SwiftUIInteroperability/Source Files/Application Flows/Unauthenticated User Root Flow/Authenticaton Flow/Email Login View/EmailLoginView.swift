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
                    configuration: .makeEmailTextInputConfiguration(),
                    value: $viewModel.email,
                    focusedField: _focusedField,
                    error: viewModel.emailError
                )
                SecureTextInput(
                    configuration: .makePasswordTextInputConfiguration(),
                    value: $viewModel.password,
                    focusedField: _focusedField,
                    error: viewModel.passwordError
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

    var canSubmit: Bool {
        viewModel.passwordError == nil && viewModel.email.count > 3 && viewModel.password.count > 3
    }

    func resignFirstResponder() {
        focusedField = nil
    }

    func setFocusDelayed(to field: TextInputType) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.focusedField = field.rawValue
        }
    }
}
