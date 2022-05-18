//
//  LocalDataServiceTests.swift
//  SwiftUI Interoperability
//

import Foundation
import XCTest
@testable import SwiftUIInteroperability

final class LocalDataServiceTest: XCTestCase {
    var fakeLocalStorage: FakeLocalStorage!
    var sut: LiveLocalDataService!

    override func setUp() {
        fakeLocalStorage = FakeLocalStorage()
        sut = LiveLocalDataService(localStorage: fakeLocalStorage)
    }

    func testHandingOnboardingCompletionFlag() {
        //  given:
        let fixtureOnboardingCompletionFlag = true
        let fixtureKey = LiveLocalDataService.Key.hasFinishedOnboardingKey.rawValue
        fakeLocalStorage.simulatedValues = [fixtureKey: fixtureOnboardingCompletionFlag]

        //  when:
        let retrievedValue = sut.hasFinishedOnboarding

        //  then:
        XCTAssertEqual(retrievedValue, fixtureOnboardingCompletionFlag, "Should return the proper value")

        //  when:
        sut.hasFinishedOnboarding = fixtureOnboardingCompletionFlag

        //  then:
        fakeLocalStorage.verifyCall(withIdentifier: "set", arguments: [fixtureOnboardingCompletionFlag, fixtureKey])
    }

    func testHandingRegisteredUser() {
        //  given:
        let fixtureRegisteredUser = UserAuthenticationInfo(email: "", password: "")
        let fixtureKey = LiveLocalDataService.Key.registeredUser.rawValue
        fakeLocalStorage.simulatedValues = [fixtureKey: fixtureRegisteredUser.data]

        //  when:
        let retrievedValue = sut.registeredUser

        //  then:
        XCTAssertEqual(retrievedValue, fixtureRegisteredUser, "Should return the proper value")

        //  when:
        sut.registeredUser = fixtureRegisteredUser

        //  then:
        fakeLocalStorage.verifyCall(withIdentifier: "set", arguments: [fixtureRegisteredUser.data, fixtureKey])
    }
}
