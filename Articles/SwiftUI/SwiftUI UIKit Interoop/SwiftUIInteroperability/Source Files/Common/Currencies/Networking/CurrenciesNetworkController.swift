//
//  CurrenciesNetworkController.swift
//  SwiftUI Interoperability
//

import Foundation

// MARK: CurrenciesNetworkController

/// An abstraction describing network controller for currencies.
protocol CurrenciesNetworkController: AnyObject {

    /// Fetches cryptocurrencies.
    ///
    /// - Parameters:
    ///   - start: a start position.
    ///   - limit: a results limit.
    ///   - completion: a completion callback.
    func fetchCurrencies(start: Int, limit: Int, completion: ((Result<FetchCurrenciesResponse, NetworkError>) -> Void)?)

    /// Fetches a cryptocurrency details.
    ///
    /// - Parameters:
    ///   - id: a currency id.
    ///   - completion: a completion callback.
    func fetchCurrencyDetails(id: Int, completion: ((Result<FetchCurrencyDetailsResponse, NetworkError>) -> Void)?)
}

// MARK: LiveCurrenciesNetworkController

/// A default implementation of CurrenciesNetworkController
final class LiveCurrenciesNetworkController: CurrenciesNetworkController {
    private let networkModule: NetworkModule

    /// A default initializer for CurrenciesNetworkController.
    ///
    /// - Parameter networkModule: a network module.
    init(networkModule: NetworkModule) {
        self.networkModule = networkModule
    }

    // MARK: Public methods

    /// SeeAlso: CurrenciesNetworkController.fetchCurrencies(start:limit:completion)
    func fetchCurrencies(start: Int, limit: Int, completion: ((Result<FetchCurrenciesResponse, NetworkError>) -> Void)?) {
        let request = FetchCurrenciesRequest(start: start, limit: limit)
        networkModule.performAndDecode(request: request, responseType: FetchCurrenciesResponse.self) { result in
            completion?(result)
        }
    }

    /// SeeAlso: CurrenciesNetworkController.fetchCurrencyDetails(id:completion)
    func fetchCurrencyDetails(id: Int, completion: ((Result<FetchCurrencyDetailsResponse, NetworkError>) -> Void)?) {
        let request = FetchCurrencyDetailsRequest(id: id)
        networkModule.performAndDecode(request: request, responseType: FetchCurrencyDetailsResponse.self) { result in
            completion?(result)
        }
    }
}
