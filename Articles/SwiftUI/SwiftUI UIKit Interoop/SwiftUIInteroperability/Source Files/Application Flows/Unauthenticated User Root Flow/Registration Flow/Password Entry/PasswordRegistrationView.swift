//
//  PasswordRegistrationView.swift
//  SwiftUI Interoperability
//

import SwiftUI

struct PasswordRegistrationView: View {

    @StateObject var viewModel: LivePasswordRegistrationViewModel
    @FocusState private var focusedField: String?

    var body: some View {
        ZStack {

            // MARK: Back navigation button

            BackNavigationView(
                tint: Colors.basicGreen.color.swiftUIColor,
                callback: viewModel.goBack
            )

            // MARK: Bottom buttons

            VStack(alignment: .center, spacing: 30) {
                Spacer()
                Button {
                    resignFirstResponder()
                    viewModel.createAccount()
                } label: {
                    Text("REGISTER").hollowedButtonText()
                }
                .disabled(!canSubmit)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            // MARK: Textfields:

            VStack(alignment: .center, spacing: 10) {
                SecureTextInput(
                    configuration: .makePasswordTextInputConfiguration(),
                    value: $viewModel.password,
                    focusedField: _focusedField,
                    error: viewModel.passwordError
                )
                SecureTextInput(
                    configuration: .makePasswordTextInputConfiguration(
                        fieldName: "repeatPassword",
                        prompt: "Repeat password"
                    ),
                    value: $viewModel.repeatedPassword,
                    focusedField: _focusedField,
                    error: viewModel.repeatedPasswordError
                )
            }
            .padding()
        }
        .onAppear {
            setFocusDelayed(to: .password)
        }
    }
}

private extension PasswordRegistrationView {

    var canSubmit: Bool {
        viewModel.passwordError == nil
            && viewModel.repeatedPasswordError == nil
            && !viewModel.password.isEmpty
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
