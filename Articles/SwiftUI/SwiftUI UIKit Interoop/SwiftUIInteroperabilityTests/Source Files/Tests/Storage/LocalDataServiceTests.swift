//
//  LocalDataServiceTests.swift
//  SwiftUI Interoperability
//

import Foundation
import XCTest
@testable import SwiftUIInteroperability

final class LocalDataServiceTest: XCTestCase {
    var fakeLocalStorage: FakeLocalStorage!
    var sut: DefaultLocalDataService!

    override func setUp() {
        fakeLocalStorage = FakeLocalStorage()
        sut = DefaultLocalDataService(localStorage: fakeLocalStorage)
    }

    func testHandingOnboardingCompletionFlag() {
        //  given:
        let fixtureOnboardingCompletionFlag = true
        let fixtureKey = DefaultLocalDataService.Keys.hasFinishedOnboardingKey.rawValue
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
        let fixtureKey = DefaultLocalDataService.Keys.registeredUser.rawValue
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
