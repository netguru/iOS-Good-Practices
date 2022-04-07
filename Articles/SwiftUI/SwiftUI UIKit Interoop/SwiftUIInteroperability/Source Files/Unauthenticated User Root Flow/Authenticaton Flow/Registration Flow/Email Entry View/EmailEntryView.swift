//
//  EmailEntryView.swift
//  SwiftUI Interoperability
//

import SwiftUI

struct EmailEntryView: View {

    @StateObject var viewModel: DefaultEmailEntryViewModel

    @FocusState private var focusedField: FocusField?

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
                    Text("LOG IN")
                        .font(.footnote)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            VStack {
                TextField(
                    "Enter email",
                    text: $viewModel.currentEmail
                )
                .onSubmit(resignFirstResponder)
                .focused($focusedField, equals: .emailEntry)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .keyboardType(.emailAddress)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.blue, lineWidth: 2)
                )
                Text(viewModel.currentValidationError?.localizedDescription ?? " ")
                    .font(.caption)
                    .foregroundColor(.red)
            }
            .padding()
        }
        .onAppear {
            setFocusDelayed(to: .emailEntry)
        }
    }
}

private extension EmailEntryView {

    /// Currently focused field.
    enum FocusField: Hashable {
        case emailEntry
    }

    var canSubmit: Bool {
        viewModel.currentValidationError == nil && viewModel.currentEmail.count > 3
    }

    func resignFirstResponder() {
        focusedField = nil
    }

    func setFocusDelayed(to field: FocusField) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.focusedField = field
        }
    }
}

struct EmailEntryView_Previews: PreviewProvider {
    static var previews: some View {
        EmailEntryView(
            viewModel: DefaultEmailEntryViewModel(
                temporaryStorage: DefaultAppDataCache()
            )
        )
    }
}
