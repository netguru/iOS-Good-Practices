//
//  ProfileView.swift
//  SwiftUI Interoperability
//

import SwiftUI

struct ProfileView: View {

    @StateObject var viewModel: DefaultProfileViewModel
    @FocusState private var focusedField: String?

    var body: some View {
        ZStack {
            Text("Profile View")
        }
        .onAppear {
            setDelayedFocus()
        }
    }
}

private extension ProfileView {

    func resignFirstResponder() {
        focusedField = nil
    }

    func setDelayedFocus() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.focusedField = ""
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(
            viewModel: DefaultProfileViewModel()
        )
    }
}
