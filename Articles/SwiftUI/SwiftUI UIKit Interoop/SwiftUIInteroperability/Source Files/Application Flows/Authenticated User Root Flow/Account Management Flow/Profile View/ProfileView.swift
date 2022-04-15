//
//  ProfileView.swift
//  SwiftUI Interoperability
//

import SwiftUI

struct ProfileView: View {

    @StateObject var viewModel: DefaultProfileViewModel

    var body: some View {
        VStack(spacing: 5) {
            Spacer()
            Text("Profile View")
            Text(viewModel.email).font(.footnote)
            Spacer()
            Button {
                viewModel.logOut()
            } label: {
                Text("LOG OUT").font(.footnote).hollowedButtonText()
            }
        }.padding()
            .onAppear {}
    }
}

private extension ProfileView {}
