//
//  ApplicationSecrets.swift
//  SwiftUI Interoperability
//

import Foundation
import Keys

/// A structure describing an application secrets provider.
protocol ApplicationSecretsProvider {

    /// An authentication token.
    var authenticationToken: String { get }

    ///  An application base URL.
    var baseUrl: String { get }
}

/// A default application secrets provider implementation.
struct ApplicationSecrets: ApplicationSecretsProvider {

    /// - SeeAlso: ApplicationSecretsProvider.authenticationToken
    let authenticationToken: String

    /// - SeeAlso: ApplicationSecretsProvider.baseUrl
    let baseUrl: String
}

extension ApplicationSecrets {

    /// A default initializer for application secrets.
    ///
    /// - Parameter cocoapodKeys: A cocoapods keys object.
    init(cocoapodKeys: SwiftUIInteroperabilityKeys) {
        authenticationToken = cocoapodKeys.authenticationToken
        baseUrl = cocoapodKeys.baseUrl
    }
}
