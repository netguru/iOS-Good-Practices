//
//  AccountManagementFlowCoordinator.swift
//  SwiftUI Interoperability
//

import UIKit

// MARK: AccountManagementFlowCoordinator

/// An abstraction describing app AccountManagement flow.
protocol AccountManagementFlowCoordinatorDelegate: AnyObject {}

/// A flow coordinator for AccountManagement flow.
final class AccountManagementFlowCoordinator: FlowCoordinator {

    // MARK: Properties

    /// A flow coordinator name.
    let name = AuthenticatedUserFlowCoordinatorName.accountManagement.rawValue

    /// A flow coordinator delegate.
    weak var delegate: AccountManagementFlowCoordinatorDelegate?

    /// A navigation controller to present the flow on.
    private(set) var presentingNavigationController: UINavigationController?

    /// A reference to the application Dependency Provider.
    private(set) unowned var dependencyProvider: DependencyProvider

    // MARK: Initializers

    /// A default initializer for AccountManagementFlowCoordinator.
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

// MARK: DashboardViewControllerDelegate

extension AccountManagementFlowCoordinator: ProfileViewControllerDelegate {

    func profileViewControllerDidFinish(_ viewController: UIViewController) {}
}

// MARK: Private Extension

private extension AccountManagementFlowCoordinator {

    func showInitialViewController(animated: Bool = true) {
        let viewModel = DefaultProfileViewModel()
        let view = ProfileView(viewModel: viewModel)
        let viewController = ProfileViewController(view: view, viewModel: viewModel)
        viewController.delegate = self
        presentingNavigationController?.pushViewController(viewController, animated: animated)
    }
}
