//
//  FakeCurrenciesNetworkController.swift
//  SwiftUI Interoperability
//

import Foundation
import Mimus

@testable import SwiftUIInteroperability

final class FakeCurrenciesNetworkController: CurrenciesNetworkController, Mock {
    var storage = Mimus.Storage()
    private var fetchCurrenciesCompletion: ((Result<FetchCurrenciesResponse, NetworkError>) -> Void)?
    private var fetchCurrencyDetailsCompletion: ((Result<FetchCurrencyDetailsResponse, NetworkError>) -> Void)?

    func fetchCurrencies(start: Int, limit: Int, completion: ((Result<FetchCurrenciesResponse, NetworkError>) -> Void)?) {
        fetchCurrenciesCompletion = completion
        recordCall(withIdentifier: "fetchCurrencies", arguments: [start, limit])
    }

    func fetchCurrencyDetails(id: Int, completion: ((Result<FetchCurrencyDetailsResponse, NetworkError>) -> Void)?) {
        fetchCurrencyDetailsCompletion = completion
        recordCall(withIdentifier: "fetchCurrencyDetails", arguments: [id])
    }
}

extension FakeCurrenciesNetworkController {

    func simulateFetchCurrenciesSuccess(response: FetchCurrenciesResponse) {
        fetchCurrenciesCompletion?(.success(response))
    }

    func simulateFetchCurrenciesFailure(error: NetworkError) {
        fetchCurrenciesCompletion?(.failure(error))
    }

    func simulateFetchCurrencyDetailsSuccess(response: FetchCurrencyDetailsResponse) {
        fetchCurrencyDetailsCompletion?(.success(response))
    }

    func simulateFetchCurrencyDetailsFailure(error: NetworkError) {
        fetchCurrencyDetailsCompletion?(.failure(error))
    }
}
