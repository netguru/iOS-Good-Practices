//
//  EmailEntryView.swift
//  SwiftUI Interoperability
//

import SwiftUI

struct EmailEntryView: View {

    @StateObject var viewModel: DefaultEmailEntryViewModel

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
                value: $viewModel.currentEmail,
                focusedField: _focusedField,
                error: viewModel.currentValidationError,
                prompt: FieldName.emailEntry.prompt,
                fieldName: FieldName.emailEntry.rawValue,
                keyboardType: .emailAddress
            )
            .padding()
        }
        .onAppear {
            setFocusDelayed(to: .emailEntry)
        }
    }
}

private extension EmailEntryView {

    /// Currently focused field.
    enum FieldName: String {
        case emailEntry

        var prompt: String {
            switch self {
            case .emailEntry:
                return "Enter email"
            }
        }
    }

    var canSubmit: Bool {
        viewModel.currentValidationError == nil && viewModel.currentEmail.count > 3
    }

    func resignFirstResponder() {
        focusedField = nil
    }

    func setFocusDelayed(to field: FieldName) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.focusedField = field.rawValue
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
