//
//  OnboardingFlowCoordinatorTests.swift
//  SwiftUI Interoperability
//

import Foundation
import XCTest
@testable import SwiftUIInteroperability

final class OnboardingFlowCoordinatorTest: XCTestCase {
    var fakePresentingNavigationController: FakeUINavigationController!
    var fakeDependencyProvider: FakeDependencyProvider!
    var sut: OnboardingFlowCoordinator!

    private var didTriggerLogIn: Bool?
    private var didTriggerSignUp: Bool?

    override func setUp() {
        fakePresentingNavigationController = FakeUINavigationController()
        fakeDependencyProvider = FakeDependencyProvider()
        sut = OnboardingFlowCoordinator(
            presentingNavigationController: fakePresentingNavigationController,
            dependencyProvider: fakeDependencyProvider
        )
        sut.delegate = self
    }

    func testShowingInitialFlow() throws {
        //  given:
        fakeDependencyProvider.fakeLocalDataService.simulatedHasFinishedOnboarding = true

        //  when:
        sut.start(animated: true)

        //  then:
        let welcomeViewController = try XCTUnwrap(fakePresentingNavigationController.viewControllers.last as? WelcomeViewController<WelcomeView>)
        XCTAssert(welcomeViewController.delegate === sut, "Should become view controller delegate")

        //  given:
        fakeDependencyProvider.fakeLocalDataService.simulatedHasFinishedOnboarding = false

        //  when:
        sut.start(animated: true)

        //  then:
        let onboardingViewController = try XCTUnwrap(fakePresentingNavigationController.viewControllers.last as? OnboardingViewController<OnboardingView>)
        XCTAssert(onboardingViewController.delegate === sut, "Should become view controller delegate")
    }

    func testNaturalUserFlow() throws {
        //  given:
        fakeDependencyProvider.fakeLocalDataService.simulatedHasFinishedOnboarding = false

        //  when:
        sut.start(animated: true)

        //  then:
        let onboardingViewController = try XCTUnwrap(fakePresentingNavigationController.viewControllers.last as? OnboardingViewController<OnboardingView>)
        XCTAssert(onboardingViewController.delegate === sut, "Should become view controller delegate")

        //  when:
        onboardingViewController.delegate?.onboardingViewControllerDidFinish(onboardingViewController)

        //  then:
        let welcomeViewController = try XCTUnwrap(fakePresentingNavigationController.viewControllers.last as? WelcomeViewController<WelcomeView>)
        XCTAssert(welcomeViewController.delegate === sut, "Should become view controller delegate")

        //  given:
        fakeDependencyProvider.fakeAppDataCache.simulatedStorage = [CacheKey.selectedAuthenticationFlow: AuthenticationFlow.signIn]

        //  when:
        welcomeViewController.delegate?.welcomeViewControllerDidFinish(welcomeViewController)

        //  then:
        XCTAssertEqual(didTriggerLogIn, true, "Should trigger sign in flow")

        //  given:
        fakeDependencyProvider.fakeAppDataCache.simulatedStorage = [CacheKey.selectedAuthenticationFlow: AuthenticationFlow.signUp]

        //  when:
        welcomeViewController.delegate?.welcomeViewControllerDidFinish(welcomeViewController)

        //  then:
        XCTAssertEqual(didTriggerSignUp, true, "Should trigger sign up flow")
    }
}

extension OnboardingFlowCoordinatorTest: OnboardingFlowCoordinatorDelegate {

    func onboardingFlowCoordinatorDidTriggerLogIn(_ coordinator: OnboardingFlowCoordinator) {
        didTriggerLogIn = true
    }

    func onboardingFlowCoordinatorDidTriggerSignUp(_ coordinator: OnboardingFlowCoordinator) {
        didTriggerSignUp = true
    }
}
