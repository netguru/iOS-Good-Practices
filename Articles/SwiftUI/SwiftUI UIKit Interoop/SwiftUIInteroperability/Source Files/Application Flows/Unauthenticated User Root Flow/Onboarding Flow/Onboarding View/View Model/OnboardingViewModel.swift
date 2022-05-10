//
//  OnboardingViewModel.swift
//  SwiftUI Interoperability
//

import Foundation

// MARK: OnboardingViewModel

/// An abstraction describing a View Model for an application initial view.
protocol OnboardingViewModel: NavigableViewModel {

    /// Calls to display next slide.
    func nextSlide()

    /// Calls to display previous slide.
    func previousSlide()

    /// Calls finish the onboarding.
    func finish()
}

// MARK: LiveOnboardingViewModel

/// A default implementation of OnboardingViewModel
class LiveOnboardingViewModel: ObservableObject, OnboardingViewModel {

    // MARK: Public Properties

    /// - SeeAlso: NavigableViewModel.onNavigationAwayFromViewRequested
    var onNavigationAwayFromViewRequested: (() -> Void)?

    /// A currently displayed slide.
    @Published var currentSlide: OnboardingSlide

    /// A current slide index.
    @Published var currentIndex = 0

    /// A total slides count.
    @Published var slidesCount = 0

    // MARK: Private Properties

    private let slides: [OnboardingSlide]
    private let localDataService: LocalDataService

    // MARK: Initializers

    /// A default OnboardingViewModel initializer.
    ///
    /// - Parameters:
    ///   - slides: a list of slides to be shown.
    ///   - localDataService: a local applicaiton storage.
    init(slides: [OnboardingSlide], localDataService: LocalDataService) {
        self.slides = slides
        self.localDataService = localDataService
        currentSlide = slides[0]
        slidesCount = slides.count
    }

    // MARK: Public methods

    /// SeeAlso: OnboardingViewModel.nextSlide()
    func nextSlide() {
        currentIndex += 1
        if currentIndex >= slides.count {
            currentIndex = slides.count - 1
        }
        currentSlide = slides[currentIndex]
    }

    /// SeeAlso: OnboardingViewModel.previousSlide()
    func previousSlide() {
        currentIndex -= 1
        if currentIndex < 0 {
            currentIndex = 0
        }
        currentSlide = slides[currentIndex]
    }

    /// SeeAlso: OnboardingViewModel.finish()
    func finish() {
        localDataService.hasFinishedOnboarding = true
        requestNavigatingAwayFromView()
    }
}

// MARK: Helper extension

extension LiveOnboardingViewModel {

    var canGoForward: Bool {
        currentIndex < slides.count - 1
    }

    var canGoBack: Bool {
        currentIndex > 0
    }
}
