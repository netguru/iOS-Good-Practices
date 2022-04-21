//
//  ProfileView.swift
//  SwiftUI Interoperability
//

import SwiftUI

struct ProfileView: View {

    @StateObject var viewModel: DefaultProfileViewModel

    var body: some View {
        Form {
            Section(header: Text("Profile information")) {
                Text("Email: \(viewModel.email)")
                Button("Logout") {
                    viewModel.logOut()
                }
            }
        }
    }
}

private extension ProfileView {}
