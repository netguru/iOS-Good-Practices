//
//  WelcomeViewControllerTests.swift
//  SwiftUI Interoperability
//

import Foundation
import XCTest
import SnapshotTesting
@testable import SwiftUIInteroperability

final class WelcomeViewControllerTest: XCTestCase {
    var fakeViewModel: FakeWelcomeViewModel!
    var sut: WelcomeViewController<WelcomeView>!

    private var didFinish: Bool?

    override func setUp() {
        let fakeViewModel = FakeWelcomeViewModel(temporaryStorage: FakeAppDataCache())
        let view = WelcomeView(viewModel: fakeViewModel)
        sut = WelcomeViewController(view: view, viewModel: fakeViewModel)
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
        sut.performSnapshotTests(named: "WelcomeViewController")
    }
}

extension WelcomeViewControllerTest: WelcomeViewControllerDelegate {

    func welcomeViewControllerDidFinish(_ viewController: UIKit.UIViewController) {
        didFinish = true
    }
}
