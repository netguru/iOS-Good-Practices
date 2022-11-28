//
//  FakeCurrenciesService.swift
//  SwiftUI Interoperability
//

import Foundation
import Mimus

@testable import SwiftUIInteroperability

final class FakeCurrenciesService: CurrenciesService, Mock {
    var storage = Mimus.Storage()
    var simulatedCurrencies: [Currency]?

    var currencies: [Currency] {
        simulatedCurrencies ?? []
    }

    private var refreshCurrenciesCompletion: ((Result<[Currency], NetworkError>) -> Void)?
    private var getCurrencyCompletion: ((Result<CurrencyDetails, NetworkError>) -> Void)?

    func refreshCurrencies(completion: ((Result<[Currency], NetworkError>) -> Void)?) {
        refreshCurrenciesCompletion = completion
        recordCall(withIdentifier: "refreshCurrencies")
    }

    func getCurrency(id: Int, completion: ((Result<CurrencyDetails, NetworkError>) -> Void)?) {
        getCurrencyCompletion = completion
        recordCall(withIdentifier: "getCurrency", arguments: [id])
    }
}

extension FakeCurrenciesService {

    func simulateRefreshCurrenciesSuccess(currencies: [Currency]) {
        refreshCurrenciesCompletion?(.success(currencies))
    }

    func simulateRefreshCurrenciesFailure(error: NetworkError) {
        refreshCurrenciesCompletion?(.failure(error))
    }

    func simulateGetCurrencySuccess(details: CurrencyDetails) {
        getCurrencyCompletion?(.success(details))
    }

    func simulateGetCurrencyFailure(error: NetworkError) {
        getCurrencyCompletion?(.failure(error))
    }
}
