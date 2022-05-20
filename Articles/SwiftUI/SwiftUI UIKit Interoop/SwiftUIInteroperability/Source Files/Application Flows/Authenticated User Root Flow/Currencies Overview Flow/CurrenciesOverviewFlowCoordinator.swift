//
//  CurrenciesOverviewFlowCoordinator.swift
//  SwiftUI Interoperability
//

import UIKit

// MARK: CurrenciesOverviewFlowCoordinator

/// An abstraction describing app CurrenciesOverview flow.
protocol CurrenciesOverviewFlowCoordinatorDelegate: AnyObject {}

/// A flow coordinator for CurrenciesOverview flow.
final class CurrenciesOverviewFlowCoordinator: FlowCoordinator {

    // MARK: Properties

    /// A flow coordinator name.
    let name = AuthenticatedUserFlowCoordinatorName.currenciesOverview.rawValue

    /// A flow coordinator delegate.
    weak var delegate: CurrenciesOverviewFlowCoordinatorDelegate?

    /// A navigation controller to present the flow on.
    private(set) var presentingNavigationController: UINavigationController?

    /// A reference to the application Dependency Provider.
    private(set) unowned var dependencyProvider: DependencyProvider

    // MARK: Initializers

    /// A default initializer for CurrenciesOverviewFlowCoordinator.
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

// MARK: CurrenciesViewControllerDelegate

extension CurrenciesOverviewFlowCoordinator: CurrenciesViewControllerDelegate {

    func currenciesViewController(_ viewController: UIViewController, didRequestShowingCurrencyDetails details: CurrencyDetails) {
        let viewModel = LiveCurrencyDetailsViewModel(details: details)
        let view = CurrencyDetailsView(viewModel: viewModel)
        let viewController = CurrencyDetailsViewController(view: view, viewModel: viewModel)
        viewController.delegate = self
        presentingNavigationController?.pushViewController(viewController, animated: true)
    }
}

extension CurrenciesOverviewFlowCoordinator: CurrencyDetailsViewControllerDelegate {

    func currencyDetailsViewControllerDidRequestBackwardsNavigation(_ viewController: UIViewController) {
        presentingNavigationController?.popViewController(animated: true)
    }
}

// MARK: Private Extension

private extension CurrenciesOverviewFlowCoordinator {

    func showInitialViewController(animated: Bool = true) {
        let viewModel = LiveCurrenciesViewModel(
            currenciesService: dependencyProvider.currenciesService,
            presentableHUD: dependencyProvider.presentableHUD,
            infoAlert: dependencyProvider.infoAlert
        )
        let view = CurrenciesView(viewModel: viewModel)
        let viewController = CurrenciesViewController(view: view, viewModel: viewModel)
        viewController.delegate = self
        presentingNavigationController?.pushViewController(viewController, animated: animated)
    }
}
