//
//  AuthenticationService.swift
//  SwiftUI Interoperability
//

//
//  AuthenticationService.swift

import Foundation

// MARK: AuthenticationService

/// An abstraction describing authentication service.
protocol AuthenticationService: AnyObject {

    /// Authenticates the user with email and password.
    ///
    /// - Parameters:
    ///   - userAuthenticationInfo: user authentication info.
    ///   - completion: a completion callback.
    func authenticate(userAuthenticationInfo: UserAuthenticationInfo, completion: ((Result<UserInfo, UserAuthenticationError>) -> Void)?)
}

// MARK: DefaultAuthenticationService

/// A default implementation of AuthenticationService
final class DefaultAuthenticationService: AuthenticationService {

    // MARK: Private Properties

    private let localStorage: LocalDataService

    // TODO: Remove when network call is implemented!
    private let delayedExecutor: DelayedOperationsExecutor = DefaultDelayedAsynchronousBlocksExecutor()

    /// A default initializer for Authentication service.
    ///
    /// - Parameter localStorage: a local storage.
    init(localStorage: LocalDataService) {
        self.localStorage = localStorage
    }

    // MARK: Public methods

    /// SeeAlso: AuthenticationService.authenticate(userAuthenticationInfo:)
    func authenticate(userAuthenticationInfo: UserAuthenticationInfo, completion: ((Result<UserInfo, UserAuthenticationError>) -> Void)?) {
        /// Discussion: This is just a placeholder for "real" authentication service.
        /// We just check if the user data is already stored in the local storage.
        /// It's not secure at all, but it's just a POC, so...
        let randomDelay = Double.random(in: 2..<4)
        delayedExecutor.executeDelayed(by: randomDelay) { [unowned self] in
            if let currentUser = localStorage.currentUser, currentUser == userAuthenticationInfo {
                let userInfo = UserInfo(id: UUID().uuidString, email: currentUser.email)
                completion?(.success(userInfo))
            } else {
                completion?(.failure(.failed))
            }
        }
    }
}

// MARK: Implementation details

private extension DefaultAuthenticationService {}
