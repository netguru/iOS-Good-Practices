//
//  DependencyProviderTests.swift
//  SwiftUI Interoperability
//

import Foundation
import XCTest
@testable import SwiftUIInteroperability

final class DependencyProviderTest: XCTestCase {

    var sut: LiveDependencyProvider!

    override func setUp() {
        sut = LiveDependencyProvider()
    }

    func testRegisteringAndRetrievingDependencies() {
        //  given:
        let fakeAppDataCache = FakeAppDataCache()

        //  when:
        sut.register(fakeAppDataCache, for: AppDataCache.self)
        sut.register(FakeCurrenciesNetworkController(), for: CurrenciesNetworkController.self)

        //  then:
        let retrievedDependency: AppDataCache = sut.resolve()
        XCTAssert(fakeAppDataCache === retrievedDependency, "Should return provided dependency, based on an interface")
    }

    func testSettingUpDependencies() {
        //  given:
        let fakePresentingViewController = FakeUINavigationController()
        let fakeWindowController = FakeWindowController()
        fakeWindowController.simulatedVisibleViewController = fakePresentingViewController

        //  when:
        sut.setup(windowController: fakeWindowController)

        //  then:
        let infoAlert: InfoAlert = sut.resolve()

        //  when:
        infoAlert.show(title: "", message: nil)

        //  then:
        let alertController = (infoAlert as? LiveInfoAlert)?.alertController
        XCTAssert(alertController === fakePresentingViewController.presentedViewController, "Should use presenting view controller provided by Window Controller")
        
        //
        // TODO: We could add tests for other critical dependencies here, but the app would crash if these are not properly added so...
        //
    }
}
