//
//  ProfileViewModelTests.swift
//  SwiftUI Interoperability
//

import Foundation
import XCTest
@testable import SwiftUIInteroperability

final class ProfileViewModelTest: XCTestCase {
    var fakeAuthenticationService: FakeAuthenticationService!
    var fakePresentableHud: FakePresentableHud!
    var fakeInfoAlert: FakeInfoAlert!
    var fakeAcceptanceAlert: FakeAcceptanceAlert!
    var sut: LiveProfileViewModel!

    override func setUp() {
        fakeAuthenticationService = FakeAuthenticationService()
        fakePresentableHud = FakePresentableHud()
        fakeInfoAlert = FakeInfoAlert()
        fakeAcceptanceAlert = FakeAcceptanceAlert()
        sut = LiveProfileViewModel(
            authenticationService: fakeAuthenticationService,
            presentableHUD: fakePresentableHud,
            infoAlert: fakeInfoAlert,
            acceptanceAlert: fakeAcceptanceAlert
        )
    }

    func testLoggingOut() {
        //  given:
        var didLogOut: Bool?
        sut.onLogout = {
            didLogOut = true
        }

        //  when:
        sut.logOut()

        //  then:
        fakeAcceptanceAlert.verifyCall(
            withIdentifier: "show",
            arguments: [
                "Logout confirmation",
                "Would you like to log out of the application?",
                "Yes",
                "No"
            ]
        )

        //  when:
        fakeAcceptanceAlert.simulateAlertDismissed(answer: .no)

        //  then:
        XCTAssertNil(didLogOut, "Should not trigger logout callback")

        //  when:
        fakeAcceptanceAlert.simulateAlertDismissed(answer: .yes)

        //  then:
        fakePresentableHud.verifyCall(withIdentifier: "show", arguments: [true])
        fakeAuthenticationService.verifyCall(withIdentifier: "logout")

        //  when:
        fakeAuthenticationService.simulateLogoutCompleted(status: false)

        //  then:
        fakeInfoAlert.verifyCall(
            withIdentifier: "show",
            arguments: ["An error has occurred", "Please try again later", "OK"]
        )
        fakePresentableHud.verifyCall(withIdentifier: "hide", arguments: [true])

        //  when:
        fakeAuthenticationService.simulateLogoutCompleted(status: true)

        //  then:
        XCTAssertEqual(didLogOut, true, "Should trigger logout callback")
        fakePresentableHud.verifyCall(withIdentifier: "hide", arguments: [true])
    }
}
