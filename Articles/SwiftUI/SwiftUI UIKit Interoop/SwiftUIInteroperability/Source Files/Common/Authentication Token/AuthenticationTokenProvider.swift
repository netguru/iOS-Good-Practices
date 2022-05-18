//
//  AuthenticationTokenProvider.swift
//  SwiftUI Interoperability
//

import Foundation

// MARK: AuthenticationTokenProvider

/// An abstraction describing an authentication token provider.
protocol AuthenticationTokenProvider: AnyObject {

    /// An authentication token.
    var accessToken: String { get }
}

// MARK: DefaultAuthenticationTokenProvider

/// A default implementation of AuthenticationTokenProvider
final class LiveAuthenticationTokenProvider: AuthenticationTokenProvider {
    private let appSecretsProvider: ApplicationSecretsProvider

    // MARK: Public Properties

    /// - SeeAlso: AuthenticationTokenProvider.accessToken
    var accessToken: String {
        appSecretsProvider.authenticationToken
    }

    // MARK: Initializers

    /// A default initializer for authentication token provider.
    ///
    /// - Parameter appSecretsProvider: an application secrets provider.
    init(appSecretsProvider: ApplicationSecretsProvider) {
        self.appSecretsProvider = appSecretsProvider
    }
}
