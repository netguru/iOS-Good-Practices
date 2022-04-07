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
    weak var rootFlowCoordinatorDelegate: RootFlowCoordinatorDelegate?

    /// A currently running flow coordinator.
    private(set) var currentFlowCoordinator: FlowCoordinator?

    /// A coordinator that has started from this one.
    private(set) var currentChildFlowCoordinator: FlowCoordinator?

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
        // TODO: Start Authentication Flow
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
}

// MARK: Implementation details

private extension UnauthenticatedUserRootFlowCoordinator {

    func startInitialFlowCoordinator() {
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

    func start(_ coordinator: FlowCoordinator, animated: Bool) {
        currentFlowCoordinator = coordinator
        coordinator.start(animated: animated)
    }
}
