//
//  FetchCurrencyDetailsRequest.swift
//  SwiftUI Interoperability
//

import Foundation

/// An abstraction describing a request to fetch currency details.
struct FetchCurrencyDetailsRequest: NetworkRequest {

    // MARK: - Properties

    /// - SeeAlso: NetworkRequest.path
    let path = "/v2/cryptocurrency/info"

    /// - SeeAlso: NetworkRequest.method
    let method = NetworkRequestMethod.get

    /// - SeeAlso: NetworkRequest.parameters
    let parameters: [String: Any]?

    // MARK: - Initializer

    /// A default initializer.
    ///
    /// - Parameter id: a currency slug.
    init(id: Int) {
        parameters = [
            "id": id
        ]
    }
}
