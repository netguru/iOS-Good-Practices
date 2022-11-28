//
//  RequestBuilder.swift
//  SwiftUI Interoperability
//

import Foundation

/// An abstraction describing a URL request builder.
protocol RequestBuilder: AnyObject {

    /// Build an URL request, based on a provided request description.
    ///
    /// - Parameter request: an URL description.
    /// - Returns: an URL request.
    func build(request: NetworkRequest) -> URLRequest?
}

/// A default implementation of a Request Builder.
final class LiveRequestBuilder: RequestBuilder {
    private let baseURL: URL

    // MARK: - Initializers

    /// A default initialized for Request Builder.
    ///
    /// - Parameter baseURL: a base url path.
    init(baseURL: URL) {
        self.baseURL = baseURL
    }

    /// - SeeAlso: RequestBuilder.build(request:)
    func build(request: NetworkRequest) -> URLRequest? {
        guard let url = composeURL(request: request) else {
            return nil
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.cachePolicy = request.cachePolicy
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.encodedBody
        appendIfNeeded(additionalHeaderFields: request.additionalHeaderFields, toRequest: &urlRequest)
        return urlRequest
    }
}

// MARK: - Implementation details

private extension LiveRequestBuilder {

    func composeURL(request: NetworkRequest) -> URL? {
        let requestPath = composeRequestPath(request: request)
        var components = URLComponents(string: requestPath)
        if let parameters = request.parameters {
            components?.queryItems = composeQueryItems(fromParameters: parameters)
        }
        return components?.url
    }

    func composeRequestPath(request: NetworkRequest) -> String {
        if request.hasAbsolutePath {
            return request.path
        } else {
            return baseURL.absoluteString + request.path
        }
    }

    func composeQueryItems(fromParameters parameters: [String: Any]) -> [URLQueryItem] {
        parameters.map {
            URLQueryItem(name: $0, value: "\($1)")
        }
    }

    func appendIfNeeded(additionalHeaderFields fields: [String: String]?, toRequest urlRequest: inout URLRequest) {
        guard let fields = fields else {
            return
        }

        for (key, value) in fields {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
    }
}
