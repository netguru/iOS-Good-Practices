//
//  CurrenciesService.swift
//  SwiftUI Interoperability
//

import Foundation

// MARK: CurrenciesService

/// An abstraction describing a service dealing with currencies.
protocol CurrenciesService: AnyObject {

    /// A current list of currencies.
    var currencies: [Currency] { get }

    /// Refreshes the currencies list.
    ///
    /// - Parameter completion: a completion callback.
    func refreshCurrencies(completion: ((Result<[Currency], NetworkError>) -> Void)?)

    /// Fetches currency details.
    ///
    /// - Parameters:
    ///   - id: a currency id.
    ///   - completion: a completion callback.
    func getCurrency(id: Int, completion: ((Result<CurrencyDetails, NetworkError>) -> Void)?)
}

// MARK: LiveCurrenciesService

/// A default implementation of CurrenciesService.
final class LiveCurrenciesService: CurrenciesService {

    /// - SeeAlso: CurrenciesService.currencies
    var currencies: [Currency] {
        localDataService.currencies
    }

    private let networkController: CurrenciesNetworkController
    private let localDataService: LocalDataService

    // MARK: Initializers

    /// A default initializer for currencies service.
    ///
    /// - Parameters:
    ///   - networkController: a network controller.
    ///   - localDataService: a local data service.
    init(
        networkController: CurrenciesNetworkController,
        localDataService: LocalDataService
    ) {
        self.networkController = networkController
        self.localDataService = localDataService
    }

    // MARK: Public methods

    /// SeeAlso: CurrenciesService.refreshCurrencies(completion:)
    func refreshCurrencies(completion: ((Result<[Currency], NetworkError>) -> Void)?) {
        networkController.fetchCurrencies(start: 1, limit: 100) { [unowned self] result in
            switch result {
            case let .success(currenciesResponse):
                localDataService.currencies = currenciesResponse.data
                completion?(.success(currenciesResponse.data))
            case let .failure(error):
                completion?(.failure(error))
            }
        }
    }

    /// SeeAlso: CurrenciesService.getCurrency(id:completion:)
    func getCurrency(id: Int, completion: ((Result<CurrencyDetails, NetworkError>) -> Void)?) {
        networkController.fetchCurrencyDetails(id: id) { result in
            switch result {
            case let .success(currencyDetailsResponse):
                completion?(.success(currencyDetailsResponse.details))
            case let .failure(error):
                completion?(.failure(error))
            }
        }
    }
}

// MARK: Implementation details

private extension LiveCurrenciesService {}
