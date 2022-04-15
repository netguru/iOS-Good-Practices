//
//  AuthenticatedUserRootFlowCoordinator.swift
//  SwiftUI Interoperability
//

import UIKit

// MARK: AuthenticatedUserRootFlowCoordinator

/// An abstraction describing a root flow coordinator for Authenticated User flow.
final class AuthenticatedUserRootFlowCoordinator: NSObject, RootFlowCoordinator {

    // MARK: Properties

    /// A flow coordinator name.
    let name = RootFlowCoordinatorName.authenticatedUser.rawValue

    /// A main navigation controller.
    /// SeeAlso: RootFlowCoordinator.navigationController.
    let navigationController: UINavigationController

    /// A Root Flow Coordinator root.
    /// SeeAlso: RootFlowCoordinator.rootViewController.
    var rootViewController: UIViewController {
        navigationController
    }

    /// A root flow coordinator delegate.
    weak var rootFlowCoordinatorDelegate: RootFlowCoordinatorDelegate?

    /// A currently running flow coordinator.
    private(set) var currentFlowCoordinator: FlowCoordinator?

    /// A coordinator that has started from this one.
//    private(set) var currentChildFlowCoordinator: FlowCoordinator?

    /// A reference to the application Dependency Provider.
    private(set) unowned var dependencyProvider: DependencyProvider

    // MARK: Private properties

    private let tabBarController = UITabBarController()
    private let dashboardFlowCoordinator: DashboardFlowCoordinator
    private let currenciesFlowCoordinator: CurrenciesOverviewFlowCoordinator
    private let accountManagementFlowCoordinator: AccountManagementFlowCoordinator

    // MARK: Initializers

    /// A default initializer for root flow coordinator.
    /// - Parameters:
    ///   - dependencyProvider: a reference to the application Dependency Provider.
    ///   - navigationController: a Navigation Controller to lay the flow on.
    init(
        dependencyProvider: DependencyProvider,
        navigationController: UINavigationController = UINavigationController()
    ) {
        self.dependencyProvider = dependencyProvider
        self.navigationController = navigationController
        dashboardFlowCoordinator = DashboardFlowCoordinator(
            presentingNavigationController: UINavigationController(),
            dependencyProvider: dependencyProvider
        )
        currenciesFlowCoordinator = CurrenciesOverviewFlowCoordinator(
            presentingNavigationController: UINavigationController(),
            dependencyProvider: dependencyProvider
        )
        accountManagementFlowCoordinator = AccountManagementFlowCoordinator(
            presentingNavigationController: UINavigationController(),
            dependencyProvider: dependencyProvider
        )
    }

    // MARK: Public methods

    /// Starts the flow.
    func start() {
        configureTabBarController()
        dashboardFlowCoordinator.delegate = self
        currenciesFlowCoordinator.delegate = self
        accountManagementFlowCoordinator.delegate = self
        tabBarController.selectedIndex = 0
        showTabBarController()
    }
}

// MARK: UITabBarDelegate

extension AuthenticatedUserRootFlowCoordinator: UITabBarControllerDelegate {

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let index = tabBarController.viewControllers?.firstIndex(of: viewController), coordinators.count > index else {
            return
        }
        currentFlowCoordinator = coordinators[index]
    }
}

extension AuthenticatedUserRootFlowCoordinator: AccountManagementFlowCoordinatorDelegate {

    func accountManagementFlowCoordinatorDidLogUserOut(_ flowCoordinator: AccountManagementFlowCoordinator) {
        finish()
    }
}

extension AuthenticatedUserRootFlowCoordinator: CurrenciesOverviewFlowCoordinatorDelegate {}

extension AuthenticatedUserRootFlowCoordinator: DashboardFlowCoordinatorDelegate {}

// MARK: Implementation details

private extension AuthenticatedUserRootFlowCoordinator {

    var coordinators: [FlowCoordinator] {
        [dashboardFlowCoordinator, currenciesFlowCoordinator, accountManagementFlowCoordinator]
    }

    func configureTabBarController() {
        tabBarController.viewControllers = coordinators.map { $0.presentingNavigationController!.visibleViewController }
        coordinators.forEach { configureFlowCoordinatorInTabBar($0) }
        tabBarController.tabBar.applyDefaultStyle()
        tabBarController.delegate = self
        currentFlowCoordinator = coordinators.first
    }

    func configureFlowCoordinatorInTabBar(_ coordinator: FlowCoordinator) {
        start(coordinator, animated: false)
        guard let coordinatorType = AuthenticatedUserFlowCoordinatorName(rawValue: coordinator.name) else {
            return
        }
        coordinator.presentingNavigationController?.tabBarItem = coordinatorType.tabBarItem
        coordinator.presentingNavigationController?.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -20, right: 0)
    }

    func start(_ coordinator: FlowCoordinator, animated: Bool) {
        currentFlowCoordinator = coordinator
        coordinator.start(animated: animated)
    }

    func showTabBarController() {
        navigationController.setNavigationBarHidden(true, animated: false)
        navigationController.setViewControllers([tabBarController], animated: false)
    }
}
