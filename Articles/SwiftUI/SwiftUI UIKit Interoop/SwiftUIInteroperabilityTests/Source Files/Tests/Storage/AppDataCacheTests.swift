//
//  AppDataCacheTests.swift
//  SwiftUI Interoperability
//

import Foundation
import XCTest
@testable import SwiftUIInteroperability

final class AppDataCacheTest: XCTestCase {
    let fixtureKey = CacheKey.selectedEmail
    let fixtureStringValue = "fixtureStringValue"
    var sut: DefaultAppDataCache!
    var retrievedValue: String?

    override func setUp() {
        sut = DefaultAppDataCache()
        retrievedValue = nil
    }

    func testInitialStorageState() {
        XCTAssertNil(sut.retrieveObject(forKey: fixtureKey), "Should not have any initial value")
    }

    func testRetrievingValue() {
        //  given:
        sut.store(fixtureStringValue, forKey: fixtureKey)

        //  when:
        retrievedValue = sut.retrieveObject(forKey: fixtureKey) as? String

        //  then:
        XCTAssertEqual(retrievedValue, fixtureStringValue, "Should retrieve stored value")
    }

    func testRetrievingAndRemovingValue() {
        //  given:
        sut.store(fixtureStringValue, forKey: fixtureKey)

        //  when:
        retrievedValue = sut.retrieveAndRemoveObject(forKey: fixtureKey) as? String

        //  then:
        XCTAssertEqual(retrievedValue, fixtureStringValue, "Should retrieve stored value")
        XCTAssertNil(sut.retrieveObject(forKey: fixtureKey), "Should remove a value after retrieving it")
    }

    func testRemovingValue() {
        //  given:
        sut.store(fixtureStringValue, forKey: fixtureKey)

        //  when:
        sut.removeObject(forKey: fixtureKey)

        //  then:
        XCTAssertNil(sut.retrieveObject(forKey: fixtureKey), "Should remove a value")
    }

    func testClearingStorage() {
        //  given:
        sut.store(fixtureStringValue, forKey: fixtureKey)

        //  when:
        sut.clear()

        //  then:
        XCTAssertNil(sut.retrieveObject(forKey: fixtureKey), "Should remove a value")
    }
}
