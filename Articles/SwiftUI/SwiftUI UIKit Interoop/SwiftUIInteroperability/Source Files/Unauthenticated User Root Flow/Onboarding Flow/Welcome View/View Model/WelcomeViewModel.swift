//
//  WelcomeViewModel.swift
//  SwiftUI Interoperability
//

import Foundation

// MARK: WelcomeViewModel

/// An abstraction describing WelcomeViewModel
protocol WelcomeViewModel: NavigableViewModel {

    /// Requests registration flow.
    func requestSignUp()

    /// Requests login flow.
    func requestLogin()
}

// MARK: DefaultWelcomeViewModel

/// A default implementation of WelcomeViewModel
final class DefaultWelcomeViewModel: ObservableObject, WelcomeViewModel {

    // MARK: Public Properties

    /// - SeeAlso: NavigableViewModel.onNavigationAwayFromViewRequested
    var onNavigationAwayFromViewRequested: (() -> Void)?

    // MARK: Private Properties

    private let temporaryStorage: AppDataCache

    // MARK: Initializer:

    init(temporaryStorage: AppDataCache) {
        self.temporaryStorage = temporaryStorage
    }

    // MARK: Public methods

    /// SeeAlso: WelcomeViewModel.requestSignUp
    func requestSignUp() {
        temporaryStorage.store(AuthenticationFlow.signUp, forKey: .selectedAuthenticationFlow)
        requestNavigatingAwayFromView()
    }

    /// SeeAlso: WelcomeViewModel.requestLogin
    func requestLogin() {
        temporaryStorage.store(AuthenticationFlow.signIn, forKey: .selectedAuthenticationFlow)
        requestNavigatingAwayFromView()
    }
}
