//
//  OnboardingSlideView.swift
//  SwiftUI Interoperability
//

import SwiftUI

/// A helper view showing an onboarding slide.
struct OnboardingSlideView: View {

    /// Slide title.
    let title: String

    /// Slide message.
    let message: String

    var body: some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                Text(title)
                    .padding(7)
                    .font(.title)
                    .background(.blue)
                    .cornerRadius(15)
                Text(message)
                    .padding(7)
                    .background(.blue)
                    .cornerRadius(15)
                Spacer()
            }
            .frame(minWidth: 100, maxWidth: 200, minHeight: 100, maxHeight: 200)
            .background(.red)
            .cornerRadius(15)
            Spacer()
        }
    }
}

// MARK: Preview

struct OnboardoingSlideView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingSlideView(
            title: "Slide 1 title",
            message: "Slide 2 message"
        )
    }
}
