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
    @Published private(set) var emailError: LocalizableError?

    /// A current password authentication error.
    @Published private(set) var passwordError: LocalizableError?

    // MARK: Private Properties

    private let authenticationService: AuthenticationService
    private let presentableHUD: PresentableHud
    private let infoAlert: InfoAlert
    private let appDataCache: AppDataCache
    private let emailValidator: Validator
    private let passwordValidator: Validator

    // MARK: Initializers

    /// A default EmailLoginViewModel initializer.
    ///
    /// - Parameter authenticationService: an authentication service.
    /// - Parameter appDataCache: an application data cache.
    /// - Parameter presentableHUD: a presentable HUD.
    /// - Parameter infoAlert: an information alert.
    /// - Parameter emailValidator: an email validator.
    /// - Parameter passwordValidator: a password validator.
    init(
        authenticationService: AuthenticationService,
        appDataCache: AppDataCache,
        presentableHUD: PresentableHud,
        infoAlert: InfoAlert,
        emailValidator: Validator = EmailValidator(),
        passwordValidator: Validator = PasswordValidator()
    ) {
        self.authenticationService = authenticationService
        self.presentableHUD = presentableHUD
        self.appDataCache = appDataCache
        self.infoAlert = infoAlert
        self.emailValidator = emailValidator
        self.passwordValidator = passwordValidator
        setupFieldValidation()
    }

    // MARK: Public methods

    /// SeeAlso: EmailLoginViewModel.commit()
    func logIn() {
        presentableHUD.show(animated: true)
        let info = UserAuthenticationInfo(email: email, password: password)
        authenticationService.authenticate(userAuthenticationInfo: info) { [weak self] result in
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

    /// SeeAlso: EmailLoginViewModel.navigateToLogIn()
    func navigateToRegistration() {
        onRegistrationFlowRequested?()
    }
}

// MARK: Implementation details

private extension DefaultEmailLoginViewModel {

    func storeInSession(user: UserInfo) {
        appDataCache.store(user, forKey: .authenticatedUser)
    }

    func setupFieldValidation() {
        $email
            .dropFirst()
            .debounce(for: 0.1, scheduler: RunLoop.main)
            .removeDuplicates()
            .map {
                self.emailValidator.validate(value: $0)
            }
            .assign(to: &$emailError)
        $password
            .dropFirst()
            .debounce(for: 0.1, scheduler: RunLoop.main)
            .removeDuplicates()
            .map {
                self.passwordValidator.validate(value: $0)
            }
            .assign(to: &$passwordError)
    }
}