//
//  NetworkSession.swift
//  SwiftUI Interoperability
//

import Foundation

/// Convenience wrapper for URL Session.
protocol NetworkSession: AnyObject {

    /// Creates a URL session data task.
    /// - Parameters:
    ///   - request: an URL request.
    ///   - completionHandler: a request completion callback.
    /// - Returns: an URL data task.
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: NetworkSession {}
