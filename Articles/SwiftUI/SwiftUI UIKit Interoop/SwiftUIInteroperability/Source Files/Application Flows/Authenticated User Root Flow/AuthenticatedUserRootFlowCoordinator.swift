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
        dashboardFlowCoordinator.delegate = self
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

extension AuthenticatedUserRootFlowCoordinator: AccountManagementFlowCoordinatorDelegate {}

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

/*
  //
 //  AuthenticatedUserRootFlowCoordinator.swift
 //  VisaMobile
 //

 import UIKit

 /// A Root Flow Coordinator covering the main part of application after login: dashboard, cards information, payments history, settings.
 final class AuthenticatedUserRootFlowCoordinator: NSObject, RootFlowCoordinator {

     // MARK: Initializers

     /// Default initializer for Account Root Flow Coordinator.
     ///
     /// - Parameters:
     ///   - dependencyProvider: a reference to the application Dependency Provider.
     ///   - navigationController: a Navigation Controller to lay the flow on.
     init(
         dependencyProvider: DependencyProvider,
         navigationController: UINavigationController = UINavigationController.makeNavigationController()
     ) {
         self.dependencyProvider = dependencyProvider
         self.navigationController = navigationController
     }

     // MARK: Public methods

     /// Starts the flow.
     /// SeeAlso: RootFlowCoordinator.start()
     func start() {
         logInfo(message: "AuthenticatedUserRootFlowCoordinator:start - root flow started")
         configureTabBarController()
         navigationController.setViewControllers([tabBarController], animated: false)
         showUserProfileIfNeeded()
     }

     /// Shows a dashboard tab.
     /// Dismisses all opened popups and external flows (eg. adding a card)
     /// Refreshes currently opened view controller on a Dashboard tab.
     func showDashboard() {
         tabBarController.selectedIndex = 0
         tabBarController.refreshVisibleViewController()
         navigationController.dismiss(animated: true)
         finishExternalFlowIfNeeded()
     }
 }

 // MARK: - FlowCoordinatorDelegate

 extension AuthenticatedUserRootFlowCoordinator: FlowCoordinatorDelegate {

     func flowCoordinatorDidFinish(_ flowCoordinator: FlowCoordinator) {
         logInfo(message: "AuthenticatedUserRootFlowCoordinator:flowCoordinatorDidFinish - Coordinator name: \(flowCoordinator.name)")
         switch flowCoordinator.name {
         case RegistrationFlowCoordinatorName.verifyCards.rawValue:
             handleCardVerificationFinished()
         case RegistrationFlowCoordinatorName.addingManuallyCards.rawValue:
             startCardVerificationFlow()
         case RegistrationFlowCoordinatorName.selectingCard.rawValue:
             handleCardSelectionFinished()
         default:
             rootFlowCoordinatorDelegate?.rootFlowCoordinatorDidFinish(self)
         }
     }
 }

 // MARK: - AccountCardsFlowCoordinatorDelegate

 extension AuthenticatedUserRootFlowCoordinator: AccountCardsFlowCoordinatorDelegate {
     func cardsFlowCoordinator(_ flowCoordinator: AccountCardsFlowCoordinator, didTriggerVerifyCard card: SRCCard) {
         logInfo(message: "AuthenticatedUserRootFlowCoordinator:cardsFlowCoordinator didTriggerVerifyCard \(card)")
         dependencyProvider.appDataCache.store(card, forKey: .manuallyAddedCard)
         startCardVerificationFlow()
     }

     func cardsFlowCoordinatorDidTriggerAddCard(_ flowCoordinator: AccountCardsFlowCoordinator) {
         logInfo(message: "AuthenticatedUserRootFlowCoordinator:cardsFlowCoordinatorDidTriggerAddCard")
         startCardRegistrationFlow()
     }
 }

 // MARK: - DashboardFlowCoordinatorDelegate

 extension AuthenticatedUserRootFlowCoordinator: DashboardFlowCoordinatorDelegate {

     func dashboardFlowCoordinatorDidTriggerAddingCard(_ flowCoordinator: DashboardFlowCoordinator) {
         logInfo(message: "AuthenticatedUserRootFlowCoordinator:dashboardFlowCoordinatorDidTriggerAddingCard")
         startCardRegistrationFlow()
     }

     func dashboardFlowCoordinatorDidTriggerSeeAllPayments(_ flowCoordinator: DashboardFlowCoordinator) {
         logInfo(message: "AuthenticatedUserRootFlowCoordinator:dashboardFlowCoordinatorDidTriggerSeeAllPayments")
         guard let paymentTabIndex = coordinators.firstIndex(where: {
             ($0 as? PaymentsHistoryFlowCoordinator) != nil
         }) else {
             logError(message: "AuthenticatedUserRootFlowCoordinator:dashboardFlowCoordinatorDidTriggerSeeAllPayments couldn't find PaymentsHistoryFlowCoordinator in coordinators tab.")
             return
         }
         tabBarController.selectedIndex = paymentTabIndex
     }

     func dashboardFlowCoordinatorDidTriggerVerifyAvailableCards(_ flowCoordinator: DashboardFlowCoordinator) {
         logInfo(message: "AuthenticatedUserRootFlowCoordinator:dashboardFlowCoordinatorDidTriggerVerifyAvailableCards")
         startCardSelectionFlow()
     }
 }

 // MARK: - ProfileCoordinatorDelegate

 extension AuthenticatedUserRootFlowCoordinator: ProfileCoordinatorDelegate {

     func profileCoordinatorDidDeleteAccount(_ flowCoordinator: ProfileFlowCoordinator) {
         logInfo(message: "AuthenticatedUserRootFlowCoordinator:profileCoordinatorDelegate - account deleted")
         finish()
     }

     func profileCoordinatorDidBlockAccount(_ flowCoordinator: ProfileFlowCoordinator) {
         logInfo(message: "AuthenticatedUserRootFlowCoordinator:profileCoordinatorDidBlockAccount")
         finish()
     }
 }

 // MARK: - Private extension

 private extension AuthenticatedUserRootFlowCoordinator {

     func finishExternalFlowIfNeeded() {
         let internalFlowCoordinatorNames = coordinators.map { $0.name }
         if let currentCoordinator = currentFlowCoordinator,
            !internalFlowCoordinatorNames.contains(currentCoordinator.name) {
             currentCoordinator.finish()
         }
     }

 }

 extension AuthenticatedUserRootFlowCoordinator: CardSelectionFlowCoordinatorDelegate {
     func cardSelectionFlowCoordinator(_ coordinator: CardSelectionFlowCoordinator, didTriggerVerifyCard card: SRCCard) {
         logInfo(message: "AuthenticatedUserRootFlowCoordinator:cardSelectionFlowCoordinator:didTriggerVerifyCard")
         startCardVerificationFlow(animated: true)
     }

     func cardSelectionFlowCoordinatorDidTriggerSkip(_ coordinator: CardSelectionFlowCoordinator) {
         logInfo(message: "AuthenticatedUserRootFlowCoordinator:cardSelectionFlowCoordinatorDidTriggerSkip")
         coordinator.finish()
     }
 }

 extension AuthenticatedUserRootFlowCoordinator: ManuallyAddedCardVerificationFlowCoordinatorDelegate {
     func manuallyAddedCardVerificationFlowCoordinatorDelegateDidTriggerBackToHome(_ manuallyAddedCardVerificationFlowCoordinator: ManuallyAddedCardVerificationFlowCoordinator) {
         logInfo(message: "AuthenticatedUserRootFlowCoordinator:manuallyAddedCardVerificationFlowCoordinatorDelegateDidTriggerBackToHome")
         showDashboard()
     }
 }

 extension AuthenticatedUserRootFlowCoordinator: ManualCardRegistrationFlowCoordinatorDelegate {
     func manualCardRegistrationFlowCoordinatorDelegateDidTriggerNotNow(_ manualCardRegistrationFlowCoordinator: ManualCardRegistrationFlowCoordinator) {
         logInfo(message: "AuthenticatedUserRootFlowCoordinator:manualCardRegistrationFlowCoordinatorDelegateDidTriggerNotNow")
         showInitialTabBarController()
     }
 }

  */
