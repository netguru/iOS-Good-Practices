//
//  NetworkModuleAction.swift
//  SwiftUI Interoperability
//

import Foundation

/// An abstraction describing a set of actions to be executed before and/or after a network call.
protocol NetworkModuleAction: AnyObject {

    /// An action to be executed before network call.
    /// Eg. adding an authentication token to the outgoing request.
    ///
    /// - Parameters:
    ///   - request: a network request.
    ///   - urlRequest: an URL request.
    func performBeforeExecutingNetworkRequest(request: NetworkRequest?, urlRequest: inout URLRequest)

    /// A request to be executed after network call.
    /// Eg. storing received authentication token in the local storage.
    ///
    /// - Parameters:
    ///   - request: a network request.
    ///   - networkResponse: a network response.
    func performAfterExecutingNetworkRequest(request: NetworkRequest?, networkResponse: NetworkResponse)
}

extension NetworkModuleAction {

    /// - SeeAlso: NetworkModuleBehaviour.performBeforeExecutingNetworkRequest(request:urlRequest:)
    func performBeforeExecutingNetworkRequest(request: NetworkRequest?, urlRequest: inout URLRequest) {}

    /// - SeeAlso: NetworkModuleBehaviour.performAfterExecutingNetworkRequest(request:networkResponse:)
    func performAfterExecutingNetworkRequest(request: NetworkRequest?, networkResponse: NetworkResponse) {}
}
