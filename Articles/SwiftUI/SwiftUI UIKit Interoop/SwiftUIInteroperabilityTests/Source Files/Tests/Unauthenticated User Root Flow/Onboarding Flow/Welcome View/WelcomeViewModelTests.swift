//
//  WelcomeViewModelTests.swift
//  SwiftUI Interoperability
//

import Foundation
import XCTest
@testable import SwiftUIInteroperability

final class WelcomeViewModelTest: XCTestCase {
    var fakeAppDataCache: FakeAppDataCache!
    var sut: DefaultWelcomeViewModel!

    private var didFinish: Bool?

    override func setUp() {
        fakeAppDataCache = FakeAppDataCache()
        sut = DefaultWelcomeViewModel(
            temporaryStorage: fakeAppDataCache
        )
        sut.onNavigationAwayFromViewRequested = {
            self.didFinish = true
        }
    }

    func testSelectingAuthenticationFlows() {
        //  when:
        sut.requestLogin()

        //  then:
        fakeAppDataCache.verifyCall(withIdentifier: "store", arguments: [AuthenticationFlow.signIn, CacheKey.selectedAuthenticationFlow])
        XCTAssertEqual(didFinish, true, "Should trigger finishing callback")

        //  given:
        didFinish = nil

        //  when:
        sut.requestSignUp()

        //  then:
        fakeAppDataCache.verifyCall(withIdentifier: "store", arguments: [AuthenticationFlow.signUp, CacheKey.selectedAuthenticationFlow])
        XCTAssertEqual(didFinish, true, "Should trigger finishing callback")
    }
}
