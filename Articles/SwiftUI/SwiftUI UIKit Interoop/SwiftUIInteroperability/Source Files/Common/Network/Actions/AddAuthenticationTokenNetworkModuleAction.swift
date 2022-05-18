//
//  AddAuthenticationTokenNetworkModuleAction.swift
//  SwiftUI Interoperability
//

import Foundation

/// A network module action adding authentication header to an outgoing request.
final class AddAuthenticationTokenNetworkModuleAction: NetworkModuleAction {

    /// An authentication token provider.
    let authenticationTokenProvider: AuthenticationTokenProvider

    /// A default initializer for authentication token provider.
    ///
    /// - Parameter authenticationTokenProvider: an authentication token provider.
    init(authenticationTokenProvider: AuthenticationTokenProvider) {
        self.authenticationTokenProvider = authenticationTokenProvider
    }

    /// - SeeAlso: AddJsonContentTypeNetworkModuleAction.performBeforeExecutingNetworkRequest(request:urlRequest:)
    func performBeforeExecutingNetworkRequest(request: NetworkRequest?, urlRequest: inout URLRequest) {
        let authenticationToken = authenticationTokenProvider.accessToken
        var headerFields = urlRequest.allHTTPHeaderFields ?? [:]
        headerFields[Constants.headerFieldName] = authenticationToken
        urlRequest.allHTTPHeaderFields = headerFields
    }
}

private extension AddAuthenticationTokenNetworkModuleAction {

    enum Constants {
        static let headerFieldName = "X-CMC_PRO_API_KEY"
    }
}
