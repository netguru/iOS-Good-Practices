//
//  EmailEntryView.swift
//  SwiftUI Interoperability
//

import SwiftUI

struct EmailEntryView: View {

    @StateObject var viewModel: LiveEmailEntryViewModel
    @FocusState private var focusedField: String?

    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 30) {
                Spacer()
                Button {
                    resignFirstResponder()
                    viewModel.commit()
                } label: {
                    Text("SUBMIT").hollowedButtonText()
                }
                .disabled(!canSubmit)
                Button {
                    resignFirstResponder()
                    viewModel.navigateToLogIn()
                } label: {
                    Text("LOG IN").font(.footnote)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            TextInput(
                configuration: .makeEmailTextInputConfiguration(),
                value: $viewModel.currentEmail,
                focusedField: _focusedField,
                error: viewModel.currentValidationError
            )
            .padding()
        }
        .onAppear {
            setDelayedFocus()
        }
    }
}

private extension EmailEntryView {

    var canSubmit: Bool {
        viewModel.currentValidationError == nil && viewModel.currentEmail.count > 3
    }

    func resignFirstResponder() {
        focusedField = nil
    }

    func setDelayedFocus() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.focusedField = TextInputType.email.rawValue
        }
    }
}

struct EmailEntryView_Previews: PreviewProvider {
    static var previews: some View {
        EmailEntryView(
            viewModel: LiveEmailEntryViewModel(
                temporaryStorage: LiveAppDataCache()
            )
        )
    }
}
