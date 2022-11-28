//
//  BackNavigationView.swift
//  SwiftUI Interoperability
//

import SwiftUI

struct BackNavigationView: View {
    let tint: Color
    let callback: (() -> Void)?

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                BackButton(tint: tint, callback: callback)
                    .frame(width: 36, height: 36)
                    .padding(10)
                Spacer()
            }
            Spacer()
        }
    }
}
