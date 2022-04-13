//
//  AuthenticationFlowCoordinator.swift
//  SwiftUI Interoperability
//

import UIKit

// MARK: AuthenticationFlowCoordinator

/// An abstraction describing app Authentication flow.
protocol AuthenticationFlowCoordinatorDelegate: AnyObject {

    /// Triggered when user successfully completed authentication.
    ///
    /// - Parameter coordinator: a coordinator.
    func authenticationFlowCoordinatorDidFinish(_ coordinator: AuthenticationFlowCoordinator)

    /// Triggered when user requested the registration flow.
    ///
    /// - Parameter coordinator: a coordinator.
    func authenticationFlowCoordinatorDidTriggerRegistrationFlow(_ coordinator: AuthenticationFlowCoordinator)
}

/// A flow coordinator for registration screen flow.
final class AuthenticationFlowCoordinator: FlowCoordinator {

    // MARK: Properties

    /// A flow coordinator name.
    let name = UnauthenticatedUserFlowCoordinatorName.authentication.rawValue

    /// A flow coordinator delegate.
    weak var delegate: AuthenticationFlowCoordinatorDelegate?

    /// A navigation controller to present the flow on.
    private(set) var presentingNavigationController: UINavigationController?

    /// A reference to the application Dependency Provider.
    private(set) unowned var dependencyProvider: DependencyProvider

    // MARK: Initializers

    /// A default initializer for AuthenticationFlowCoordinator.
    ///
    /// - Parameters:
    ///   - presentingNavigationController: a navigation controller to present the flow on.
    ///   - dependencyProvider: a reference to the application Dependency Provider.
    init(
        presentingNavigationController: UINavigationController,
        dependencyProvider: DependencyProvider
    ) {
        self.presentingNavigationController = presentingNavigationController
        self.dependencyProvider = dependencyProvider
    }

    // MARK: Public methods

    /// SeeAlso: FlowCoordinator.start()
    func start(animated: Bool) {
        showInitialViewController(animated: animated)
    }

    /// SeeAlso: FlowCoordinator.finish()
    func finish() {
        delegate?.authenticationFlowCoordinatorDidFinish(self)
    }
}

// MARK: EmailEntryViewControllerDelegate

extension AuthenticationFlowCoordinator: EmailLoginViewControllerDelegate {

    func emailLoginViewControllerDidFinish(_ viewController: UIViewController) {
        finish()
    }

    func emailLoginViewControllerDidRequestNavigatingToRegistration(_ viewController: UIViewController) {
        delegate?.authenticationFlowCoordinatorDidTriggerRegistrationFlow(self)
    }
}

// MARK: Private Extension

private extension AuthenticationFlowCoordinator {

    func showInitialViewController(animated: Bool = true) {
        let viewModel = DefaultEmailLoginViewModel(
            authenticationService: dependencyProvider.authenticationService,
            appDataCache: dependencyProvider.temporaryStorage,
            presentableHUD: dependencyProvider.presentableHUD,
            infoAlert: dependencyProvider.infoAlert
        )
        let view = EmailLoginView(viewModel: viewModel)
        let viewController = EmailLoginViewController(view: view, viewModel: viewModel)
        viewController.delegate = self
        presentingNavigationController?.pushViewController(viewController, animated: animated)
    }
}
