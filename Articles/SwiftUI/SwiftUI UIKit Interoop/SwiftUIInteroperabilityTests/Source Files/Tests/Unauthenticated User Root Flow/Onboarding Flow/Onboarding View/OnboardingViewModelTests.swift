//
//  OnboardingViewModelTests.swift
//  SwiftUI Interoperability
//

import Foundation
import XCTest
@testable import SwiftUIInteroperability

final class OnboardingViewModelTest: XCTestCase {
    var fixtureSlide1 = OnboardingSlide(title: "title 1", message: "message 1")
    var fixtureSlide2 = OnboardingSlide(title: "title 2", message: "message 2")
    var fixtureSlide3 = OnboardingSlide(title: "title 3", message: "message 3")
    var fakeLocalDataService: FakeLocalDataService!
    var sut: DefaultOnboardingViewModel!

    override func setUp() {
        fakeLocalDataService = FakeLocalDataService()
        let fixtureSlides = [fixtureSlide1, fixtureSlide2, fixtureSlide3]
        sut = DefaultOnboardingViewModel(
            slides: fixtureSlides,
            localDataService: fakeLocalDataService
        )
    }

    func testInitialSetup() {
        XCTAssertEqual(sut.currentSlide, fixtureSlide1, "Should have proper initial slide")
        XCTAssertEqual(sut.slidesCount, 3, "Should have proper slides count")
    }

    func testWorkingWithSlides() {
        //  when:
        sut.nextSlide()

        //  then:
        XCTAssertEqual(sut.currentSlide, fixtureSlide2, "Should have proper next slide")

        //  when:
        sut.nextSlide()

        //  then:
        XCTAssertEqual(sut.currentSlide, fixtureSlide3, "Should have proper next slide")

        //  when:
        sut.nextSlide()

        //  then:
        XCTAssertEqual(sut.currentSlide, fixtureSlide3, "Should not exceed slides limit")

        //  when:
        sut.previousSlide()

        //  then:
        XCTAssertEqual(sut.currentSlide, fixtureSlide2, "Should have proper previous slide")

        //  when:
        sut.previousSlide()

        //  then:
        XCTAssertEqual(sut.currentSlide, fixtureSlide1, "Should have proper previous slide")

        //  when:
        sut.previousSlide()

        //  then:
        XCTAssertEqual(sut.currentSlide, fixtureSlide1, "Should not allow to go below he initial slide")
    }

    func testFinishingOnboarding() {
        //  given:
        var didFinish = false
        sut.onNavigationAwayFromViewRequested = {
            didFinish = true
        }

        //  when:
        sut.finish()

        //  then:
        fakeLocalDataService.verifyCall(withIdentifier: "hasFinishedOnboarding", arguments: [true])
        XCTAssertEqual(didFinish, true, "Should trigger a finishing callback")
    }
}
