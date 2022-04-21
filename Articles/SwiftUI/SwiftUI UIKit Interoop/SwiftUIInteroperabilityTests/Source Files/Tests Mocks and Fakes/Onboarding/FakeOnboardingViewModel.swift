//
//  FakeOnboardingViewModel.swift
//  SwiftUI Interoperability
//

import Foundation
import Mimus

@testable import SwiftUIInteroperability

final class FakeOnboardingViewModel: DefaultOnboardingViewModel, Mock {
    var storage = Mimus.Storage()

    func setState(
        currentSlide: OnboardingSlide,
        currentIndex: Int,
        slidesCount: Int
    ) {
        self.currentSlide = currentSlide
        self.slidesCount = slidesCount
        self.currentIndex = currentIndex
    }

    override func nextSlide() {
        recordCall(withIdentifier: "nextSlide")
    }

    override func previousSlide() {
        recordCall(withIdentifier: "previousSlide")
    }

    override func finish() {
        recordCall(withIdentifier: "finish")
    }
}
