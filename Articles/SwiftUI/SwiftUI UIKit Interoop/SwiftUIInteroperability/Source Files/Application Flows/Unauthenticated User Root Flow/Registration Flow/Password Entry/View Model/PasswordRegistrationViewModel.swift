//
//  PasswordRegistrationViewModel.swift
//  SwiftUI Interoperability
//

import Foundation
import SwiftUI

// MARK: PasswordRegistrationViewModel

/// An abstraction describing a View Model for an application initial view.
protocol PasswordRegistrationViewModel: NavigableViewModel {

    /// A callback to be triggered when the view has requested to go back in navigation stack.
    var onGoBackRequested: (() -> Void)? { get set }

    /// Creates user account.
    func createAccount()

    /// Requests backwards navigation.
    func goBack()
}

// MARK: DefaultPasswordRegistrationViewModel

/// A default implementation of PasswordRegistrationViewModel.
class DefaultPasswordRegistrationViewModel: ObservableObject, PasswordRegistrationViewModel {

    // MARK: Public Properties

    /// - SeeAlso: NavigableViewModel.onNavigationAwayFromViewRequested
    var onNavigationAwayFromViewRequested: (() -> Void)?

    /// - SeeAlso: NavigableViewModel.onGoBackRequested
    var onGoBackRequested: (() -> Void)?

    /// Entered password.
    @Published var password: String = ""

    /// Repeated password.
    @Published var repeatedPassword: String = ""

    /// Password error.
    @Published private(set) var passwordError: LocalizableError?

    /// Repeated password error.
    @Published private(set) var repeatedPasswordError: LocalizableError?

    // MARK: Private Properties

    private let registrationService: RegistrationService
    private let presentableHUD: PresentableHud
    private let infoAlert: InfoAlert
    private let appDataCache: AppDataCache
    private let passwordValidator: Validator

    // MARK: Initializers

    /// A default PasswordRegistrationViewModel initializer.
    init(
        registrationService: RegistrationService,
        appDataCache: AppDataCache,
        presentableHUD: PresentableHud,
        infoAlert: InfoAlert,
        passwordValidator: Validator = PasswordValidator()
    ) {
        self.registrationService = registrationService
        self.presentableHUD = presentableHUD
        self.appDataCache = appDataCache
        self.infoAlert = infoAlert
        self.passwordValidator = passwordValidator
        setupFieldValidation()
    }

    // MARK: Public methods

    /// - SeeAlso: PasswodRegistrationModel.createAccount()
    func createAccount() {
        guard let email = appDataCache.retrieveObject(forKey: .selectedEmail) as? String else {
            handleUnknownEmail()
            return
        }

        presentableHUD.show(animated: true)
        let info = UserAuthenticationInfo(email: email, password: password)
        registrationService.register(userAuthenticationInfo: info) { [weak self] result in
            self?.presentableHUD.hide(animated: true)
            switch result {
            case let .success(user):
                self?.storeInSession(user: user)
                self?.requestNavigatingAwayFromView()
            case let .failure(error):
                self?.infoAlert.show(
                    title: "An error has occurred",
                    message: error.localizedDescription
                )
            }
        }
    }

    /// - SeeAlso: PasswordRegistrationViewModel.goBack()
    func goBack() {
        onGoBackRequested?()
    }
}

// MARK: Implementation details

private extension DefaultPasswordRegistrationViewModel {

    func setupFieldValidation() {
        $password
            .dropFirst()
            .debounce(for: 0.1, scheduler: RunLoop.main)
            .removeDuplicates()
            .map {
                self.passwordValidator.validate(value: $0)
            }
            .assign(to: &$passwordError)
        $repeatedPassword
            .dropFirst()
            .debounce(for: 0.1, scheduler: RunLoop.main)
            .removeDuplicates()
            .map {
                self.password == $0 ? nil : PasswordValidationError.notMatching
            }
            .assign(to: &$repeatedPasswordError)
    }

    func storeInSession(user: UserInfo) {
        appDataCache.store(user, forKey: .authenticatedUser)
    }

    func handleUnknownEmail() {
        infoAlert.show(
            title: "An unknown error has occurred",
            message: "Try registering again"
        ) { [weak self] in
            self?.onNavigationAwayFromViewRequested?()
        }
    }
}
