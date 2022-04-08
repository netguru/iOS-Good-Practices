//
//  RegistrationFlowCoordinator.swift
//  SwiftUI Interoperability
//

import UIKit

// MARK: RegistrationFlowCoordinator

/// An abstraction describing app Registration flow.
protocol RegistrationFlowCoordinatorDelegate: AnyObject {

    /// Triggered when user successfully completed registration flow.
    ///
    /// - Parameter coordinator: a coordinator.
    func registrationFlowCoordinatorDidFinish(_ coordinator: RegistrationFlowCoordinator)

    /// Triggered when user requested the authentication flow.
    ///
    /// - Parameter coordinator: a coordinator.
    func registrationFlowCoordinatorDidTriggerAuthenticationFlow(_ coordinator: RegistrationFlowCoordinator)
}

/// A flow coordinator for registration screen flow.
final class RegistrationFlowCoordinator: FlowCoordinator {

    // MARK: Properties

    /// A flow coordinator name.
    let name = UnauthenticatedUserFlowCoordinatorName.registration.rawValue

    /// A flow coordinator delegate.
    weak var delegate: RegistrationFlowCoordinatorDelegate?

    /// A navigation controller to present the flow on.
    private(set) var presentingNavigationController: UINavigationController?

    /// A reference to the application Dependency Provider.
    private(set) unowned var dependencyProvider: DependencyProvider

    // MARK: Initializers

    /// A default initializer for RegistrationFlowCoordinator.
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
    func finish() {}
}

// MARK: EmailEntryViewControllerDelegate

extension RegistrationFlowCoordinator: EmailEntryViewControllerDelegate {

    func emailEntryViewControllerDidFinish(_ viewController: UIViewController) {
        // TODO: Show password entry view.
    }

    func emailEntryViewControllerDidRequestNavigatingToLogIn(_ viewController: UIViewController) {
        delegate?.registrationFlowCoordinatorDidTriggerAuthenticationFlow(self)
    }
}

// MARK: Private Extension

private extension RegistrationFlowCoordinator {

    func showInitialViewController(animated: Bool = true) {
        let viewModel = DefaultEmailEntryViewModel(
            temporaryStorage: dependencyProvider.temporaryStorage
        )
        let view = EmailEntryView(viewModel: viewModel)
        let viewController = EmailEntryViewController(view: view, viewModel: viewModel)
        viewController.delegate = self
        presentingNavigationController?.pushViewController(viewController, animated: animated)
    }
}
