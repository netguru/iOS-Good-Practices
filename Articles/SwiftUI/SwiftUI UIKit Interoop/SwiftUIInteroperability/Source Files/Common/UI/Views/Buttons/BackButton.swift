//
//  BackButton.swift
//  SwiftUI Interoperability
//

import SwiftUI

struct BackButton: View {
    let tint: Color
    let callback: (() -> Void)?

    var body: some View {
        Button {
            callback?()
        } label: {
            Image(systemName: "chevron.backward.circle")
                .resizable()
                .tint(tint)
                .scaledToFit()
        }
    }
}
