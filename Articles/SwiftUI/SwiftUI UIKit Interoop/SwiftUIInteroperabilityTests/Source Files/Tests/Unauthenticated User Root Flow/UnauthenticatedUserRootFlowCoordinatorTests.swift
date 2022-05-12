//
//  UnauthenticatedUserRootFlowCoordinatorTests.swift
//  SwiftUI Interoperability
//

import Foundation
import XCTest
@testable import SwiftUIInteroperability

final class UnauthenticatedUserRootFlowCoordinatorTest: XCTestCase {
    var fakePresentingNavigationController: FakeUINavigationController!
    var fakeDependencyProvider: FakeDependencyProvider!
    var sut: UnauthenticatedUserRootFlowCoordinator!

    private var didFinish: Bool?

    override func setUp() {
        fakePresentingNavigationController = FakeUINavigationController()
        fakeDependencyProvider = FakeDependencyProvider()
        sut = UnauthenticatedUserRootFlowCoordinator(
            dependencyProvider: fakeDependencyProvider,
            navigationController: fakePresentingNavigationController
        )
        sut.delegate = self
    }

    func testCoordinatorSetup() {
        XCTAssert(sut.rootViewController === fakePresentingNavigationController, "Should use provided navigation controller as root")
    }

    func testInitialFlow() throws {
        //  when:
        sut.start()

        //  then:
        let onboardingFlowCoordinator = try XCTUnwrap(sut.currentFlowCoordinator as? OnboardingFlowCoordinator)
        XCTAssert(onboardingFlowCoordinator.delegate === sut, "Should start a proper flow coordinator and become its delegate")

        //  given:
        fakeDependencyProvider.fakeLocalDataService.simulatedRegisteredUser = UserAuthenticationInfo(email: "", password: "")

        //  when:
        sut.start()

        //  then:
        let authenticationFlowCoordinator = try XCTUnwrap(sut.currentFlowCoordinator as? AuthenticationFlowCoordinator)
        XCTAssert(authenticationFlowCoordinator.delegate === sut, "Should start a proper flow coordinator and become its delegate")
    }

    func testNewUserFlow() throws {
        //  given:
        sut.start()
        let onboardingFlowCoordinator = try XCTUnwrap(sut.currentFlowCoordinator as? OnboardingFlowCoordinator)

        //  when:
        onboardingFlowCoordinator.delegate?.onboardingFlowCoordinatorDidTriggerSignUp(onboardingFlowCoordinator)

        //  then:
        let registrationFlowCoordinator = try XCTUnwrap(sut.currentFlowCoordinator as? RegistrationFlowCoordinator)
        XCTAssert(registrationFlowCoordinator.delegate === sut, "Should start a proper flow coordinator")

        //  when:
        registrationFlowCoordinator.delegate?.registrationFlowCoordinatorDidFinish(registrationFlowCoordinator)

        //  then:
        XCTAssertEqual(didFinish, true, "Should notify delegate that the flow is finished")
    }

    func testReturningUserFlow() throws {
        //  given:
        fakeDependencyProvider.fakeLocalDataService.simulatedRegisteredUser = UserAuthenticationInfo(email: "", password: "")
        sut.start()
        let authenticationFlowCoordinator = try XCTUnwrap(sut.currentFlowCoordinator as? AuthenticationFlowCoordinator)

        //  when:
        authenticationFlowCoordinator.delegate?.authenticationFlowCoordinatorDidFinish(authenticationFlowCoordinator)

        //  then:
        XCTAssertEqual(didFinish, true, "Should notify delegate that the flow is finished")
    }

    func testSwitchingBetweenFlows() throws {
        //  given:
        sut.start()
        let onboardingFlowCoordinator = try XCTUnwrap(sut.currentFlowCoordinator as? OnboardingFlowCoordinator)
        onboardingFlowCoordinator.delegate?.onboardingFlowCoordinatorDidTriggerLogIn(onboardingFlowCoordinator)

        //  then:
        let authenticationFlowCoordinator = try XCTUnwrap(sut.currentFlowCoordinator as? AuthenticationFlowCoordinator)
        XCTAssert(authenticationFlowCoordinator.delegate === sut, "Should start authentication coordinator and become its delegate")

        //  when:
        authenticationFlowCoordinator.delegate?.authenticationFlowCoordinatorDidTriggerRegistrationFlow(authenticationFlowCoordinator)

        //  then:
        let registrationFlowCoordinator = try XCTUnwrap(sut.currentFlowCoordinator as? RegistrationFlowCoordinator)
        XCTAssert(registrationFlowCoordinator.delegate === sut, "Should start a new registration flow coordinator and become its delegate")

        //  when:
        registrationFlowCoordinator.delegate?.registrationFlowCoordinatorDidTriggerAuthenticationFlow(registrationFlowCoordinator)

        //  then:
        let nextAuthenticationFlowCoordinator = try XCTUnwrap(sut.currentFlowCoordinator as? AuthenticationFlowCoordinator)
        XCTAssert(nextAuthenticationFlowCoordinator.delegate === sut, "Should start a new authentication flow coordinator and become its delegate")
    }
}

extension UnauthenticatedUserRootFlowCoordinatorTest: RootFlowCoordinatorDelegate {
    func rootFlowCoordinatorDidFinish(_ rootFlowCoordinator: RootFlowCoordinator) {
        didFinish = true
    }
}
