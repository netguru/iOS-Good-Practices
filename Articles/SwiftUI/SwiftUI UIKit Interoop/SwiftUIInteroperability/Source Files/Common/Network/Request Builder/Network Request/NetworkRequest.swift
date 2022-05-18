//
//  NetworkRequest.swift
//  SwiftUI Interoperability
//

import Foundation

/// An abstraction describing networking module request.
protocol NetworkRequest {

    /// A request path.
    var path: String { get }

    /// A request method.
    var method: NetworkRequestMethod { get }

    /// A request caching policy.
    var cachePolicy: NSURLRequest.CachePolicy { get }

    /// Additional request header fields.
    var additionalHeaderFields: [String: String]? { get }

    /// A request parameters.
    var parameters: [String: Any]? { get }

    /// A request body.
    var body: [String: Any]? { get }
}

/// Default implementation of NetworkRequest protocol.
extension NetworkRequest {

    /// - SeeAlso: NetworkRequest.parameters
    var parameters: [String: Any]? {
        nil
    }

    /// - SeeAlso: NetworkRequest.body
    var body: [String: Any]? {
        nil
    }

    /// - SeeAlso: NetworkRequest.cachePolicy
    var cachePolicy: NSURLRequest.CachePolicy {
        .reloadIgnoringCacheData
    }

    /// - SeeAlso: NetworkRequest.additionalHeaderFields
    var additionalHeaderFields: [String: String]? {
        nil
    }
}

extension NetworkRequest {

    /// A helper property providing encoded request body.
    var encodedBody: Data? {
        if let body = body,
           let bodyData = try? JSONSerialization.data(withJSONObject: body) {
            return bodyData
        }
        return nil
    }

    var hasAbsolutePath: Bool {
        if let url = URL(string: path), url.host != nil {
            return true
        }
        return false
    }
}
