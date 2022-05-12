//
//  DashboardView.swift
//  SwiftUI Interoperability
//

import SwiftUI

struct DashboardView: View {

    @StateObject var viewModel: DefaultDashboardViewModel
    @FocusState private var focusedField: String?

    var body: some View {
        ZStack {
            Text("Dashboard view")
        }
        .onAppear {
            setDelayedFocus()
        }
    }
}

private extension DashboardView {

    func resignFirstResponder() {
        focusedField = nil
    }

    func setDelayedFocus() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.focusedField = ""
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(
            viewModel: DefaultDashboardViewModel()
        )
    }
}
