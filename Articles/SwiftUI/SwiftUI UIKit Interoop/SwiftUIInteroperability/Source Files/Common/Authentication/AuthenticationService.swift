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

    /// Convenience method providing information about currently logged in user.
    var loggedInUser: UserInfo? { get }

    /// Authenticates the user with email and password.
    ///
    /// - Parameters:
    ///   - userAuthenticationInfo: user authentication info.
    ///   - completion: a completion callback.
    func authenticate(userAuthenticationInfo: UserAuthenticationInfo, completion: ((Result<UserInfo, UserAuthenticationError>) -> Void)?)

    /// Logs user out.
    ///
    /// - Parameter completion: a completion callback.
    func logout(completion: ((Bool) -> Void)?)
}

// MARK: LiveAuthenticationService

/// A default implementation of AuthenticationService
final class LiveAuthenticationService: AuthenticationService {

    // MARK: Public properties

    var loggedInUser: UserInfo? {
        appDataCache.retrieveObject(forKey: .authenticatedUser) as? UserInfo
    }

    // MARK: Private Properties

    private let localStorage: LocalDataService
    private let appDataCache: AppDataCache

    // TODO: Remove when network call is implemented!
    private let delayedExecutor: DelayedOperationsExecutor = LiveDelayedAsynchronousBlocksExecutor()

    /// A default initializer for Authentication service.
    ///
    /// - Parameter localStorage: a local storage.
    /// - Parameter appDataCache: a temporary data storage.
    init(localStorage: LocalDataService, appDataCache: AppDataCache) {
        self.localStorage = localStorage
        self.appDataCache = appDataCache
    }

    // MARK: Public methods

    /// SeeAlso: AuthenticationService.authenticate(userAuthenticationInfo:)
    func authenticate(userAuthenticationInfo: UserAuthenticationInfo, completion: ((Result<UserInfo, UserAuthenticationError>) -> Void)?) {
        if let loggedInUser = loggedInUser, loggedInUser.email == userAuthenticationInfo.email {
            let userInfo = UserInfo(id: UUID().uuidString, email: loggedInUser.email)
            completion?(.success(userInfo))
            return
        }

        /// Discussion: This is just a placeholder for "real" authentication service.
        /// We just check if the user data is already stored in the local storage.
        /// It's not secure at all, but it's just a POC, so...
        let randomDelay = Double.random(in: 2..<4)
        delayedExecutor.executeDelayed(by: randomDelay) { [unowned self] in
            if let currentUser = localStorage.registeredUser, currentUser == userAuthenticationInfo {
                let userInfo = UserInfo(id: UUID().uuidString, email: currentUser.email)
                appDataCache.store(userInfo, forKey: .authenticatedUser)
                completion?(.success(userInfo))
            } else {
                completion?(.failure(.failed))
            }
        }
    }

    /// SeeAlso: AuthenticationService.logout(completion:)
    func logout(completion: ((Bool) -> Void)?) {
        /// Discussion: This is just a placeholder for "real" authentication service.
        /// We just remove user data and execute callback after a delay...
        let randomDelay = Double.random(in: 1..<2)
        delayedExecutor.executeDelayed(by: randomDelay) { [unowned self] in
            appDataCache.removeObject(forKey: .authenticatedUser)
            completion?(true)
        }
    }
}
