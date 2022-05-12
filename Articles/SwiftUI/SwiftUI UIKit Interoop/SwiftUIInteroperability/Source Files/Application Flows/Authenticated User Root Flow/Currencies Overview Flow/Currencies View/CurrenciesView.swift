//
//  CurrenciesView.swift
//  SwiftUI Interoperability
//

import SwiftUI

struct CurrenciesView: View {

    @StateObject var viewModel: DefaultCurrenciesViewModel
    @FocusState private var focusedField: String?

    var body: some View {
        ZStack {
            Text("Currencies View")
        }
        .onAppear {
            setDelayedFocus()
        }
    }
}

private extension CurrenciesView {

    func resignFirstResponder() {
        focusedField = nil
    }

    func setDelayedFocus() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.focusedField = ""
        }
    }
}

struct CurrenciesView_Previews: PreviewProvider {
    static var previews: some View {
        CurrenciesView(
            viewModel: DefaultCurrenciesViewModel()
        )
    }
}
