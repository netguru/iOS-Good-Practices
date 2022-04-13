//
//  RegistrationService.swift
//  SwiftUI Interoperability
//

import Foundation

// MARK: RegistrationService

/// An abstraction describing registration service.
protocol RegistrationService: AnyObject {

    /// Register the user with email and password.
    ///
    /// - Parameters:
    ///   - userAuthenticationInfo: user authentication info.
    ///   - completion: a completion callback.
    func register(userAuthenticationInfo: UserAuthenticationInfo, completion: ((Result<UserInfo, UserRegistrationError>) -> Void)?)
}

// MARK: DefaultRegistrationService

/// A default implementation of RegistrationService
final class DefaultRegistrationService: RegistrationService {

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

    /// SeeAlso: RegistrationService.register(userAuthenticationInfo:)
    func register(userAuthenticationInfo: UserAuthenticationInfo, completion: ((Result<UserInfo, UserRegistrationError>) -> Void)?) {
        /// Discussion: This is just a placeholder for "real" authentication service.
        /// We just check if the user data is already stored in the local storage.
        /// It's not secure at all, but it's just a POC, so...
        let randomDelay = Double.random(in: 2..<4)
        delayedExecutor.executeDelayed(by: randomDelay) { [unowned self] in
            if let currentUser = localStorage.currentUser, currentUser.email == userAuthenticationInfo.email {
                completion?(.failure(.emailTaken))
            } else {
                localStorage.currentUser = userAuthenticationInfo
                let userInfo = UserInfo(id: UUID().uuidString, email: userAuthenticationInfo.email)
                completion?(.success(userInfo))
            }
        }
    }
}
