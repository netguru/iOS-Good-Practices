//
//  NetworkModule.swift
//  SwiftUI Interoperability
//

import UIKit
import Network

/// An abstraction describing networking module for the app.
protocol NetworkModule: AnyObject {

    /// Performs a desired network request and executes a completion callback on receiving an answer.
    ///
    /// - Parameters:
    ///   - request: a request to execute.
    ///   - completion: a completion callback.
    /// - Returns: a URL session task.
    @discardableResult func perform(
        request: NetworkRequest,
        completion: ((Result<NetworkResponse, NetworkError>) -> Void)?
    ) -> URLSessionTask?
}

extension NetworkModule {

    /// A convenience method to perform request and decode response.
    ///
    ///
    /// - Parameters:
    ///   - request: a request to execute.
    ///   - responseType: a response type.
    ///   - completion: a completion callback.
    /// - Returns: a session task.
    @discardableResult func performAndDecode<T: Decodable>(
        request: NetworkRequest,
        responseType: T.Type,
        completion: ((Result<T, NetworkError>) -> Void)?
    ) -> URLSessionTask? {
        perform(request: request) { result in
            switch result {
            case let .success(response):
                completion?(response.decode(responseStructureType: responseType))
            case let .failure(error):
                completion?(.failure(error))
            }
        }
    }
}

/// Default implementation of NetworkModule.
final class LiveNetworkModule: NetworkModule {

    // MARK: Properties

    /// Request builder instance.
    let requestBuilder: RequestBuilder

    /// URL session instance.
    let urlSession: NetworkSession

    /// Array of behaviours to be executed before and / or after network call.
    let actions: [NetworkModuleAction]

    /// Executor on which completion callbacks are executed.
    let completionExecutor: AsynchronousOperationsExecutor

    /// A default initializer for an application network module.
    ///
    /// - Parameters:
    ///   - requestBuilder: a request builder.
    ///   - urlSession: an URL session.
    ///   - actions: a set of actions to be performed before or after network call.
    ///   - completionExecutor: a completion callback
    init(
        requestBuilder: RequestBuilder,
        urlSession: NetworkSession,
        actions: [NetworkModuleAction],
        completionExecutor: AsynchronousOperationsExecutor = MainQueueOperationsExecutor()
    ) {
        self.requestBuilder = requestBuilder
        self.urlSession = urlSession
        self.actions = actions
        self.completionExecutor = completionExecutor
    }

    /// SeeAlso: NetworkModule.perform(request:completion:)
    @discardableResult func perform(
        request: NetworkRequest,
        completion: ((Result<NetworkResponse, NetworkError>) -> Void)?
    ) -> URLSessionTask? {
        guard var urlRequest = requestBuilder.build(request: request) else {
            executeOnMainThread(completionCallback: completion, result: .failure(.requestParsingFailed))
            return nil
        }

        performActionsBeforeNetworkCall(request: request, urlRequest: &urlRequest)

        let task = urlSession.dataTask(with: urlRequest) { [weak self] data, response, error in
            guard let self = self else {
                return
            }

            if let error = error as NSError? {
                self.handle(error: error, completion: completion)
            } else if let response = response as? HTTPURLResponse {
                self.handle(response: response, data: data, request: request, completion: completion)
            } else {
                self.executeOnMainThread(completionCallback: completion, result: .failure(NetworkError.unknown))
            }
        }
        task.resume()

        return task
    }
}

// MARK: Implementation details.

private extension LiveNetworkModule {

    func handle(
        response: HTTPURLResponse,
        data: Data?,
        request: NetworkRequest,
        completion: ((Result<NetworkResponse, NetworkError>) -> Void)?
    ) {
        if requestSucceed(response: response) {
            let networkResponse = NetworkResponse(data: data, networkResponse: response)
            performActionsAfterNetworkCall(request: request, response: networkResponse)
            executeOnMainThread(completionCallback: completion, result: .success(networkResponse))
        } else {
            let networkError = parse(urlResponse: response)
            executeOnMainThread(completionCallback: completion, result: .failure(networkError))
        }
    }

    func handle(error: NSError, completion: ((Result<NetworkResponse, NetworkError>) -> Void)?) {
        if error.code == Constants.requestCancelledCode {
            return
        }
        let networkError = parse(error: error)
        executeOnMainThread(completionCallback: completion, result: .failure(networkError))
    }

    func executeOnMainThread(
        completionCallback callback: ((Result<NetworkResponse, NetworkError>) -> Void)?,
        result: Result<NetworkResponse, NetworkError>
    ) {
        completionExecutor.execute {
            callback?(result)
        }
    }

    func performActionsBeforeNetworkCall(request: NetworkRequest?, urlRequest: inout URLRequest) {
        for behavior in actions {
            behavior.performBeforeExecutingNetworkRequest(request: request, urlRequest: &urlRequest)
        }
    }

    func performActionsAfterNetworkCall(request: NetworkRequest?, response: NetworkResponse) {
        for behavior in actions {
            behavior.performAfterExecutingNetworkRequest(request: request, networkResponse: response)
        }
    }

    func parse(error: NSError) -> NetworkError {
        if let error = NetworkError(code: error.code, message: error.localizedDescription) {
            return error
        } else {
            return NetworkError.unknown
        }
    }

    func parse(urlResponse: HTTPURLResponse) -> NetworkError {
        if let error = NetworkError(code: urlResponse.statusCode, message: nil) {
            return error
        } else {
            return NetworkError.unknown
        }
    }

    func requestSucceed(response: HTTPURLResponse) -> Bool {
        response.statusCode < Constants.networkErrorCode
    }
}

private extension LiveNetworkModule {

    enum Constants {
        static let networkErrorCode = 400
        static let requestCancelledCode = -999
    }
}
