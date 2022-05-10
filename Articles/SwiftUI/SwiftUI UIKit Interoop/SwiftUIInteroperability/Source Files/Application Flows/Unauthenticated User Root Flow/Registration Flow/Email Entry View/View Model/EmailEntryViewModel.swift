//
//  EmailEntryViewModel.swift
//  SwiftUI Interoperability
//

import Foundation

// MARK: EmailEntryViewModel

/// An abstraction describing a View Model for an application initial view.
protocol EmailEntryViewModel: NavigableViewModel {

    /// A callback to be called when user requested signing in.
    var onSignInFlowRequested: (() -> Void)? { get set }

    /// Called when user requested registering an email.
    func commit()

    /// Called wen user decided to log in instead.
    func navigateToLogIn()
}

// MARK: LiveEmailEntryViewModel

/// A default implementation of EmailEntryViewModel.
class LiveEmailEntryViewModel: ObservableObject, EmailEntryViewModel {

    // MARK: Public Properties

    /// - SeeAlso: NavigableViewModel.onNavigationAwayFromViewRequested
    var onNavigationAwayFromViewRequested: (() -> Void)?

    /// - SeeAlso: NavigableViewModel.onSignInFlowRequested
    var onSignInFlowRequested: (() -> Void)?

    /// A currently entered email.
    @Published var currentEmail: String = ""

    /// A current email validation error.
    @Published private(set) var currentValidationError: LocalizableError?

    // MARK: Private Properties

    private let temporaryStorage: AppDataCache
    private let emailValidator: Validator

    // MARK: Initializers

    /// A default EmailEntryViewModel initializer.
    ///
    /// - Parameter temporaryStorage: a temporary storage.
    /// - Parameter emailValidator: an email validator.
    init(temporaryStorage: AppDataCache, emailValidator: Validator = EmailValidator()) {
        self.temporaryStorage = temporaryStorage
        self.emailValidator = emailValidator
        setupEmailValidation()
    }

    // MARK: Public methods

    /// SeeAlso: EmailEntryViewModel.commit()
    func commit() {
        //  TODO: Add checking if the email is not already taken.
        temporaryStorage.store(currentEmail, forKey: .selectedEmail)
        requestNavigatingAwayFromView()
    }

    /// SeeAlso: EmailEntryViewModel.navigateToLogIn()
    func navigateToLogIn() {
        onSignInFlowRequested?()
    }
}

// MARK: Implementation details

private extension LiveEmailEntryViewModel {

    func setupEmailValidation() {
        $currentEmail
            .dropFirst()
            .debounce(for: 0.1, scheduler: RunLoop.main)
            .removeDuplicates()
            .map {
                self.emailValidator.validate(value: $0)
            }
            .assign(to: &$currentValidationError)
    }
}
