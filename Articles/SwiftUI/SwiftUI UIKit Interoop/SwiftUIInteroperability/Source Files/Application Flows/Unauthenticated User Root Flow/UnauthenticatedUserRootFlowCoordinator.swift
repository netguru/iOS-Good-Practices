//
//  UnauthenticatedUserRootFlowCoordinator.swift
//  SwiftUI Interoperability
//

import UIKit

/// An onboarding root flow coordinator names.
enum UnauthenticatedUserFlowCoordinatorName: String {
    case onboarding, registration, authentication
}

// MARK: UnauthenticatedUserRootFlowCoordinator

/// An abstraction describing a root flow coordinator for Unauthenticated User flow.
final class UnauthenticatedUserRootFlowCoordinator: RootFlowCoordinator {

    // MARK: Properties

    /// A flow coordinator name.
    let name = RootFlowCoordinatorName.unauthenticatedUser.rawValue

    /// A main navigation controller.
    /// SeeAlso: RootFlowCoordinator.navigationController.
    let navigationController: UINavigationController

    /// A Root Flow Coordinator root.
    /// SeeAlso: RootFlowCoordinator.rootViewController.
    var rootViewController: UIViewController {
        navigationController
    }

    /// A root flow coordinator delegate.
    weak var delegate: RootFlowCoordinatorDelegate?

    /// A currently running flow coordinator.
    private(set) var currentFlowCoordinator: FlowCoordinator?

    /// A reference to the application Dependency Provider.
    private(set) unowned var dependencyProvider: DependencyProvider

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
    }

    // MARK: Public methods

    /// Starts the flow.
    func start() {
        startInitialFlowCoordinator()
    }
}

// MARK: OnboardingFlowCoordinatorDelegate

extension UnauthenticatedUserRootFlowCoordinator: OnboardingFlowCoordinatorDelegate {

    func onboardingFlowCoordinatorDidTriggerLogIn(_ coordinator: OnboardingFlowCoordinator) {
        startAuthenticationFlow()
    }

    func onboardingFlowCoordinatorDidTriggerSignUp(_ coordinator: OnboardingFlowCoordinator) {
        startRegistrationFlow()
    }
}

// MARK: RegistrationFlowCoordinatorDelegate

extension UnauthenticatedUserRootFlowCoordinator: RegistrationFlowCoordinatorDelegate {

    func registrationFlowCoordinatorDidFinish(_ coordinator: RegistrationFlowCoordinator) {
        finish()
    }

    func registrationFlowCoordinatorDidTriggerAuthenticationFlow(_ coordinator: RegistrationFlowCoordinator) {
        startAuthenticationFlow()
    }
}

// MARK: AuthenticationFlowCoordinatorDelegate

extension UnauthenticatedUserRootFlowCoordinator: AuthenticationFlowCoordinatorDelegate {

    func authenticationFlowCoordinatorDidFinish(_ coordinator: AuthenticationFlowCoordinator) {
        finish()
    }

    func authenticationFlowCoordinatorDidTriggerRegistrationFlow(_ coordinator: AuthenticationFlowCoordinator) {
        startRegistrationFlow()
    }
}

// MARK: Implementation details

private extension UnauthenticatedUserRootFlowCoordinator {

    func startInitialFlowCoordinator() {
        let storage: LocalDataService = dependencyProvider.resolve()
        if storage.registeredUser != nil {
            startAuthenticationFlow()
        } else {
            startOnboardingFlowCoordinator()
        }
    }

    func startOnboardingFlowCoordinator() {
        let coordinator = OnboardingFlowCoordinator(
            presentingNavigationController: navigationController,
            dependencyProvider: dependencyProvider
        )
        coordinator.delegate = self
        start(coordinator, animated: false)
    }

    func startRegistrationFlow() {
        let coordinator = RegistrationFlowCoordinator(
            presentingNavigationController: navigationController,
            dependencyProvider: dependencyProvider
        )
        coordinator.delegate = self
        start(coordinator, animated: true)
    }

    func startAuthenticationFlow() {
        let coordinator = AuthenticationFlowCoordinator(
            presentingNavigationController: navigationController,
            dependencyProvider: dependencyProvider
        )
        coordinator.delegate = self
        start(coordinator, animated: true)
    }

    func start(_ coordinator: FlowCoordinator, animated: Bool) {
        currentFlowCoordinator = coordinator
        coordinator.start(animated: animated)
    }
}
