//
//  FetchCurrenciesRequest.swift
//  SwiftUI Interoperability
//

import Foundation

/// An abstraction describing a request to fetch
struct FetchCurrenciesRequest: NetworkRequest {

    // MARK: - Properties

    /// - SeeAlso: NetworkRequest.path
    let path = "/v1/cryptocurrency/listings/latest"

    /// - SeeAlso: NetworkRequest.method
    let method = NetworkRequestMethod.get

    /// - SeeAlso: NetworkRequest.parameters
    let parameters: [String: Any]?

    // MARK: - Initializer

    /// A default initializer.
    ///
    /// - Parameters:
    ///   - start: a starting position.
    ///   - limit: a results limit.
    init(start: Int, limit: Int) {
        parameters = [
            "start": start,
            "limit": limit
        ]
    }
}
