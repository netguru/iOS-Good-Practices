//
//  AddJsonContentTypeNetworkModuleAction.swift
//  SwiftUI Interoperability
//

import Foundation

/// A network action adding content type to an outgoing network request.
final class AddJsonContentTypeNetworkModuleAction: NetworkModuleAction {

    /// - SeeAlso: AddJsonContentTypeNetworkModuleAction.performBeforeExecutingNetworkRequest(request:urlRequest:)
    func performBeforeExecutingNetworkRequest(request: NetworkRequest?, urlRequest: inout URLRequest) {
        urlRequest.addValue(Constants.headerValue, forHTTPHeaderField: Constants.headerName)
    }
}

private extension AddJsonContentTypeNetworkModuleAction {

    enum Constants {
        static let headerValue = "application/json"
        static let headerName = "Content-Type"
    }
}
