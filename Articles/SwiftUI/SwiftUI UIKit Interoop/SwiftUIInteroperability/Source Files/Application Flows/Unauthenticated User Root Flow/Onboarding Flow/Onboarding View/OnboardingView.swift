//
//  OnboardingView.swift
//  SwiftUI Interoperability
//

import SwiftUI

/// A View showing onboarding slides.
struct OnboardingView: View {

    /// A view model.
    @StateObject var viewModel: DefaultOnboardingViewModel

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Spacer()
            OnboardingSlideView(
                title: viewModel.currentSlide.title,
                message: viewModel.currentSlide.message
            )
            Text(footerText)
                .font(.footnote)
            Spacer()
            HStack {
                Spacer()
                Button {
                    viewModel.previousSlide()
                } label: {
                    Text("<<").hollowedButtonText()
                }
                .disabled(!viewModel.canGoBack)
                Spacer()
                Button {
                    viewModel.finish()
                } label: {
                    Text(skipButtonText).hollowedButtonText()
                }
                Spacer()
                Button {
                    viewModel.nextSlide()
                } label: {
                    Text(">>").hollowedButtonText()
                }
                .disabled(!viewModel.canGoForward)
                Spacer()
            }
            Spacer()
        }
    }
}

// MARK: Implementation details

private extension OnboardingView {

    var skipButtonText: String {
        viewModel.currentIndex == viewModel.slidesCount - 1 ? "CONTINUE" : "SKIP"
    }

    var footerText: String {
        "Onboarding Slide \(viewModel.currentIndex + 1) / \(viewModel.slidesCount)"
    }
}

// MARK: Preview

struct InitialView_Previews: PreviewProvider {

    class PreviewOnboardingViewModel: DefaultOnboardingViewModel {}

    static var previews: some View {
        OnboardingView(
            viewModel: PreviewOnboardingViewModel(
                slides: [
                    OnboardingSlide(title: "slide 1", message: "message 1"),
                    OnboardingSlide(title: "slide 2", message: "message 2"),
                    OnboardingSlide(title: "slide 3", message: "message 3")
                ],
                localDataService: DefaultLocalDataService()
            )
        )
    }
}
