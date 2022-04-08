//
//  EmailLoginViewModel.swift
//  SwiftUI Interoperability
//

import Foundation

// MARK: EmailLoginViewModel

/// An abstraction describing a View Model for an application initial view.
protocol EmailLoginViewModel: NavigableViewModel {

    /// A callback to be called when user requested registration.
    var onRegistrationFlowRequested: (() -> Void)? { get set }

    /// Called when user wants to log in.
    func logIn()

    /// Called wen user decided to sign up instead.
    func navigateToRegistration()
}

// MARK: DefaultEmailLoginViewModel

/// A default implementation of EmailLoginViewModel.
class DefaultEmailLoginViewModel: ObservableObject, EmailLoginViewModel {

    // MARK: Public Properties

    /// - SeeAlso: NavigableViewModel.onNavigationAwayFromViewRequested
    var onNavigationAwayFromViewRequested: (() -> Void)?

    /// - SeeAlso: NavigableViewModel.onRegistrationFlowRequested
    var onRegistrationFlowRequested: (() -> Void)?

    /// A currently entered email.
    @Published var email: String = ""

    /// A currently entered password.
    @Published var password: String = ""

    /// A current email authentication error.
    @Published private(set) var currentAuthenticationError: LocalizableError?

    // MARK: Private Properties

    private let authenticationService: AuthenticationService

    // MARK: Initializers

    /// A default EmailLoginViewModel initializer.
    ///
    /// - Parameter authenticationService: an authentication service.
    init(authenticationService: AuthenticationService) {
        self.authenticationService = authenticationService
    }

    // MARK: Public methods

    /// SeeAlso: EmailLoginViewModel.commit()
    func logIn() {
        //  TODO: Check logging in
        requestNavigatingAwayFromView()
    }

    /// SeeAlso: EmailLoginViewModel.navigateToLogIn()
    func navigateToRegistration() {
        onRegistrationFlowRequested?()
    }
}

// MARK: Implementation details

private extension DefaultEmailLoginViewModel {}
