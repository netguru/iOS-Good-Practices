//
//  AcceptanceAlertTests.swift
//  SwiftUI Interoperability
//

import UIKit
import XCTest
@testable import SwiftUIInteroperability

final class AcceptanceAlertTest: XCTestCase {
    var fakeUINavigationController: FakeUINavigationController!
    var sut: DefaultAcceptanceAlert!

    override func setUp() {
        fakeUINavigationController = FakeUINavigationController()
        sut = DefaultAcceptanceAlert(viewControllerProvider: fakeUINavigationController)
    }

    func testShowingAcceptanceAlert() {
        //  given:
        let fixtureTitle = "fixtureTitle"
        let fixtureMessage = "fixtureMessage"
        let fixtureYesActionTitle = "fixtureYes"
        let fixtureNoActionTitle = "fixtureNo"
        var receivedAlertAction: AcceptanceAlertAction?

        //  when:
        sut.show(
            title: fixtureTitle,
            message: fixtureMessage,
            yesActionTitle: fixtureYesActionTitle,
            noActionTitle: fixtureNoActionTitle
        ) { action in
            receivedAlertAction = action
        }

        //  then:
        fakeUINavigationController.verifyCall(withIdentifier: "present", arguments: [true])
        XCTAssertEqual(sut.alertController?.title, fixtureTitle, "Should display proper title")
        XCTAssertEqual(sut.alertController?.message, fixtureMessage, "Should display proper message")
        XCTAssertEqual(sut.alertController?.preferredStyle, .alert, "Should present alert controller")
        XCTAssertEqual(sut.alertController?.actions.count, 2, "Should allow to answer yes or no")
        XCTAssertEqual(sut.alertController?.actions.first?.title, fixtureNoActionTitle, "Should assign proper action title")
        XCTAssertEqual(sut.alertController?.actions.first?.style, UIAlertAction.Style.default, "Should assign proper action style")
        XCTAssertEqual(sut.alertController?.actions.last?.title, fixtureYesActionTitle, "Should assign proper action title")
        XCTAssertEqual(sut.alertController?.actions.last?.style, UIAlertAction.Style.default, "Should assign proper action style")

        //  when:
        sut.alertController?.tapAction(atIndex: 0)

        //  then:
        XCTAssertEqual(receivedAlertAction, .no, "Should dismiss an alert with a proper action")

        //  when:
        sut.alertController?.tapAction(atIndex: 1)

        //  then:
        XCTAssertEqual(receivedAlertAction, .yes, "Should dismiss an alert with a proper action")
    }
}
