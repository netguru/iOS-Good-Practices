//
//  DashboardFlowCoordinator.swift
//  SwiftUI Interoperability
//

import UIKit

// MARK: DashboardFlowCoordinator

/// An abstraction describing app Dashboard flow.
protocol DashboardFlowCoordinatorDelegate: AnyObject {}

/// A flow coordinator for Dashboard flow.
final class DashboardFlowCoordinator: FlowCoordinator {

    // MARK: Properties

    /// A flow coordinator name.
    let name = AuthenticatedUserFlowCoordinatorName.dashboard.rawValue

    /// A flow coordinator delegate.
    weak var delegate: DashboardFlowCoordinatorDelegate?

    /// A navigation controller to present the flow on.
    private(set) var presentingNavigationController: UINavigationController?

    /// A reference to the application Dependency Provider.
    private(set) unowned var dependencyProvider: DependencyProvider

    // MARK: Initializers

    /// A default initializer for DashboardFlowCoordinator.
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

extension DashboardFlowCoordinator: DashboardViewControllerDelegate {

    func dashboardViewControllerDidFinish(_ viewController: UIViewController) {}
}

// MARK: Private Extension

private extension DashboardFlowCoordinator {

    func showInitialViewController(animated: Bool = true) {
        let viewModel = DefaultDashboardViewModel()
        let view = DashboardView(viewModel: viewModel)
        let viewController = DashboardViewController(view: view, viewModel: viewModel)
        viewController.delegate = self
        presentingNavigationController?.pushViewController(viewController, animated: animated)
    }
}
