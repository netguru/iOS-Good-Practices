//
//  ButtonViewModifiers.swift
//  SwiftUI Interoperability
//

import SwiftUI

/// A modifier drawing a hollow button with rounded corners.
struct HollowRoundedButtonText: ViewModifier {

    func body(content: Content) -> some View {
        content
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 2)
            )
    }
}

extension View {

    func hollowedButtonText() -> some View {
        modifier(HollowRoundedButtonText())
    }
}
