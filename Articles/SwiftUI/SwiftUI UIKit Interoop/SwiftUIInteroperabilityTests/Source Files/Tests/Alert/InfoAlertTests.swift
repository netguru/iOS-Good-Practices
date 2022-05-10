//
//  InfoAlertTests.swift
//  SwiftUI Interoperability
//

import Foundation
import XCTest
@testable import SwiftUIInteroperability

final class InfoAlertTest: XCTestCase {
    var fakeUINavigationController: FakeUINavigationController!
    var sut: LiveInfoAlert!

    override func setUp() {
        fakeUINavigationController = FakeUINavigationController()
        sut = LiveInfoAlert(viewControllerProvider: fakeUINavigationController)
    }

    func testShowingInformationAlert() {
        //  given:
        let fixtureTitle = "fixtureTitle"
        let fixtureMessage = "fixtureMessage"
        var didDismiss: Bool?

        //  when:
        sut.show(title: fixtureTitle, message: fixtureMessage) {
            didDismiss = self.sut.alertController?.isBeingPresented == false
        }

        //  then:
        fakeUINavigationController.verifyCall(withIdentifier: "present", arguments: [true])
        XCTAssertEqual(sut.alertController?.title, fixtureTitle, "Should display proper title")
        XCTAssertEqual(sut.alertController?.message, fixtureMessage, "Should display proper message")
        XCTAssertEqual(sut.alertController?.preferredStyle, .alert, "Should present alert controller")
        XCTAssertEqual(sut.alertController?.actions.count, 1, "Should allow only to dismiss an alert")

        //  when:
        sut.alertController?.tapAction(atIndex: 0)

        //  then:
        XCTAssertEqual(didDismiss, true, "Should dismiss an alert")
    }
}
