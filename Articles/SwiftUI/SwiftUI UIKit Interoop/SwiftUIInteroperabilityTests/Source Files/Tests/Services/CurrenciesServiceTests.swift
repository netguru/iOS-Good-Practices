//
//  CurrenciesServiceTests.swift
//  SwiftUI Interoperability
//

import Foundation
import XCTest
@testable import SwiftUIInteroperability

final class CurrenciesServiceTest: XCTestCase {
    var fakeLocalDataService: FakeLocalDataService!
    var fakeCurrenciesNetworkController: FakeCurrenciesNetworkController!
    var sut: LiveCurrenciesService!

    override func setUp() {
        fakeLocalDataService = FakeLocalDataService()
        fakeCurrenciesNetworkController = FakeCurrenciesNetworkController()
        sut = LiveCurrenciesService(
            networkController: fakeCurrenciesNetworkController,
            localDataService: fakeLocalDataService
        )
    }

    func testProvidingCachedCurrencies() {
        //  initially:
        XCTAssertEqual(sut.currencies.isEmpty, true, "Should contain no currencies")

        //  given:
        let fixtureCurrency = Currency.makeFixtureCurrency()

        //  when:
        fakeLocalDataService.simulatedCurrencies = [fixtureCurrency]

        //  then:
        XCTAssertEqual(sut.currencies, [fixtureCurrency], "Should return cached currencies")
    }

    func testFetchingCurrencies() {
        //  given:
        var receivedCurrencies: [Currency]?
        var receivedError: NetworkError?

        //  when:
        sut.refreshCurrencies { result in
            switch result {
            case let .success(currencies):
                receivedCurrencies = currencies
            case let .failure(error):
                receivedError = error
            }
        }

        //  then:
        fakeCurrenciesNetworkController.verifyCall(withIdentifier: "fetchCurrencies", arguments: [1, 100])

        //  given:
        let fixtureCurrencies = [Currency.makeFixtureCurrency()]

        //  when:
        fakeCurrenciesNetworkController.simulateFetchCurrenciesSuccess(response: .init(data: fixtureCurrencies))

        //  then:
        XCTAssertEqual(receivedCurrencies, fixtureCurrencies, "Should return provided currencies")

        //  given:
        let fixtureError = NetworkError.timedOut

        //  when:
        fakeCurrenciesNetworkController.simulateFetchCurrenciesFailure(error: fixtureError)

        //  then:
        XCTAssertEqual(receivedError, fixtureError, "Should return proper error")
    }

    func testFetchingCurrencyDetails() {
        //  given:
        let fixtureId = 1
        var receivedCurrencyDetails: CurrencyDetails?
        var receivedError: NetworkError?

        //  when:
        sut.getCurrency(id: fixtureId) { result in
            switch result {
            case let .success(details):
                receivedCurrencyDetails = details
            case let .failure(error):
                receivedError = error
            }
        }

        //  then:
        fakeCurrenciesNetworkController.verifyCall(withIdentifier: "fetchCurrencyDetails", arguments: [fixtureId])

        //  given:
        let fixtureCurrencyDetails = CurrencyDetails.makeFixtureCurrencyDetails()

        //  when:
        fakeCurrenciesNetworkController.simulateFetchCurrencyDetailsSuccess(response: .init(data: ["1": fixtureCurrencyDetails]))

        //  then:
        XCTAssertEqual(receivedCurrencyDetails, fixtureCurrencyDetails, "Should return provided details")

        //  given:
        let fixtureError = NetworkError.timedOut

        //  when:
        fakeCurrenciesNetworkController.simulateFetchCurrencyDetailsFailure(error: fixtureError)

        //  then:
        XCTAssertEqual(receivedError, fixtureError, "Should return proper error")
    }
}

extension CurrencyDetails {

    static func makeFixtureCurrencyDetails(id: Int = 1) -> CurrencyDetails {
        CurrencyDetails(
            id: id,
            name: "fixtureName",
            symbol: "fixtureSymbol",
            description: "fixture description",
            logo: "",
            slug: "",
            tags: nil
        )
    }
}
