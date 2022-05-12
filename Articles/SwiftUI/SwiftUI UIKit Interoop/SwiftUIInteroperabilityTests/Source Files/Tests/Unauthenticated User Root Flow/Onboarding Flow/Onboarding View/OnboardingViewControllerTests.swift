//
//  OnboardingViewControllerTests.swift
//  SwiftUI Interoperability
//

import UIKit
import SwiftUI
import XCTest
import SnapshotTesting
@testable import SwiftUIInteroperability

final class OnboardingViewControllerTest: XCTestCase {
    let fixtureSlide1 = OnboardingSlide(title: "title 1", message: "message 1")
    let fixtureSlide2 = OnboardingSlide(title: "title 2", message: "message 2")
    var fakeViewModel: FakeOnboardingViewModel!
    var sut: OnboardingViewController<OnboardingView>!

    private var didFinish: Bool?

    override func setUp() {
        let fakeViewModel = FakeOnboardingViewModel(
            slides: [fixtureSlide1, fixtureSlide2],
            localDataService: FakeLocalDataService()
        )
        let view = OnboardingView(viewModel: fakeViewModel)
        sut = OnboardingViewController(view: view, viewModel: fakeViewModel)
        self.fakeViewModel = fakeViewModel
    }

    func testNotifyingDelegate() {
        //  given:
        sut.delegate = self

        //  when:
        fakeViewModel.requestNavigatingAwayFromView()

        //  then:
        XCTAssertEqual(didFinish, true, "Should notify the delegate")
    }

    func testSnapshots() {
        //  given:
        fakeViewModel.setState(currentSlide: fixtureSlide1, currentIndex: 0, slidesCount: 2)

        //  then:
        sut.performSnapshotTests(named: "OnboardingViewController-slide-1")

        //  given:
        fakeViewModel.setState(currentSlide: fixtureSlide2, currentIndex: 1, slidesCount: 2)

        //  then:
        sut.performSnapshotTests(named: "OnboardingViewController-slide-2")
    }
}

extension OnboardingViewControllerTest: OnboardingViewControllerDelegate {

    func onboardingViewControllerDidFinish(_ viewController: UIViewController) {
        didFinish = true
    }
}
