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
    ///   - email: an email.
    ///   - password: a password.
    ///   - completion: a completion callback.
    func authenticate(withEmail email: String, password: String, completion: ((Result<UserInfo, UserAuthenticationError>) -> Void)?)
}

// MARK: DefaultAuthenticationService

/// A default implementation of AuthenticationService
final class DefaultAuthenticationService: AuthenticationService {

    // MARK: Private Properties

    private let localStorage: LocalDataService

    /// A default initializer for Authentication service.
    /// 
    /// - Parameter localStorage: a local storage.
    init(localStorage: LocalDataService) {
        self.localStorage = localStorage
    }

    // MARK: Public methods

    /// SeeAlso: AuthenticationService.authenticate(email:password:completion:)
    func authenticate(withEmail email: String, password: String, completion: ((Result<UserInfo, UserAuthenticationError>) -> Void)?) {}
}

// MARK: Implementation details

private extension DefaultAuthenticationService {}
