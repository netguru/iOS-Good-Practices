//
//  WelcomeView.swift
//  SwiftUI Interoperability
//

import SwiftUI

// MARK: WelcomeView

/// A SwiftUI view shown to user after finishing onboarding.
struct WelcomeView: View {

    /// A view model.
    @StateObject var viewModel: LiveWelcomeViewModel

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Spacer()
            Text("WELCOME!")
                .font(.largeTitle)
            Spacer()
            HStack {
                Spacer()
                Button {
                    viewModel.requestSignUp()
                } label: {
                    Text("SIGN UP").hollowedButtonText()
                }
                Spacer()
                Button {
                    viewModel.requestLogin()
                } label: {
                    Text("LOG IN").hollowedButtonText()
                }
                Spacer()
            }
            Spacer()
        }
    }
}

// MARK: Preview

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(viewModel: LiveWelcomeViewModel(temporaryStorage: LiveAppDataCache()))
    }
}
