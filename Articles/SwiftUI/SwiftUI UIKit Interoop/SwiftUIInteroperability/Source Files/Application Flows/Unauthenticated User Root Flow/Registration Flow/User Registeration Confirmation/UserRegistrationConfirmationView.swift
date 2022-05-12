//
//  UserRegistrationConfirmationView.swift
//  SwiftUI Interoperability
//

import SwiftUI

struct UserRegistrationConfirmationView: View {

    @StateObject var viewModel: LiveUserRegistrationConfirmationViewModel

    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Spacer()
            Text("Account registered!!!").font(.largeTitle)
            Text("Your email: \(viewModel.email)")
            Spacer()
            Button {
                viewModel.requestNavigatingAwayFromView()
            } label: {
                Text("CONTINUE")
                    .font(.footnote)
                    .hollowedButtonText()
            }
            Spacer()
        }
    }
}

struct UserRegistrationConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        UserRegistrationConfirmationView(
            viewModel: LiveUserRegistrationConfirmationViewModel(appDataCache: LiveAppDataCache())
        )
    }
}
