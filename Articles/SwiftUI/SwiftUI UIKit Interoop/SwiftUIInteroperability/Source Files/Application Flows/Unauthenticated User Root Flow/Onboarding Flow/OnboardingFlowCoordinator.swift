//
//  OnboardingFlowCoordinator.swift
//  SwiftUI Interoperability
//

import UIKit

// MARK: OnboardingFlowCoordinator

/// An abstraction describing app Onboarding / Welcome flow.
protocol OnboardingFlowCoordinatorDelegate: AnyObject {

    /// Triggered when user requested the log in flow.
    ///
    /// - Parameter coordinator: a coordinator.
    func onboardingFlowCoordinatorDidTriggerLogIn(_ coordinator: OnboardingFlowCoordinator)

    /// Triggered when user requested the registration flow.
    ///
    /// - Parameter coordinator: a coordinator.
    func onboardingFlowCoordinatorDidTriggerSignUp(_ coordinator: OnboardingFlowCoordinator)
}

/// A flow coordinator for onboarding / welcome screen flow.
final class OnboardingFlowCoordinator: FlowCoordinator {

    // MARK: Properties

    /// A flow coordinator name.
    let name = UnauthenticatedUserFlowCoordinatorName.onboarding.rawValue

    /// A flow coordinator delegate.
    weak var delegate: OnboardingFlowCoordinatorDelegate?

    /// A navigation controller to present the flow on.
    private(set) var presentingNavigationController: UINavigationController?

    /// A reference to the application Dependency Provider.
    private(set) unowned var dependencyProvider: DependencyProvider

    // MARK: Initializers

    /// A default initializer for OnboardingFlowCoordinator.
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
        guard let selectedFlow = dependencyProvider.temporaryStorage.retrieveObject(forKey: .selectedAuthenticationFlow) as? AuthenticationFlow else {
            fatalError("Authentication flow not selected! This should never occur!")
        }
        switch selectedFlow {
        case .signIn:
            delegate?.onboardingFlowCoordinatorDidTriggerLogIn(self)
        case .signUp:
            delegate?.onboardingFlowCoordinatorDidTriggerSignUp(self)
        }
    }
}

// MARK: InitialViewControllerDelegate

extension OnboardingFlowCoordinator: OnboardingViewControllerDelegate {

    func onboardingViewControllerDidFinish(_ viewController: UIViewController) {
        showWelcomeScreen(animated: true)
    }
}

// MARK: WelcomeViewControllerDelegate

extension OnboardingFlowCoordinator: WelcomeViewControllerDelegate {

    func welcomeViewControllerDidFinish(_ viewController: UIViewController) {
        finish()
    }
}

// MARK: Private Extension

private extension OnboardingFlowCoordinator {

    func showInitialViewController(animated: Bool = true) {
        if dependencyProvider.permanentStorage.hasFinishedOnboarding {
            showWelcomeScreen(animated: false)
        } else {
            showOnboardingScreen(animated: false)
        }
    }

    func showOnboardingScreen(animated: Bool) {
        let slides = [
            OnboardingSlide(title: "slide title 1", message: "slide message 1"),
            OnboardingSlide(title: "slide title 2", message: "slide message 2"),
            OnboardingSlide(title: "slide title 3", message: "slide message 3")
        ]
        let viewModel = LiveOnboardingViewModel(
            slides: slides,
            localDataService: dependencyProvider.permanentStorage
        )
        let view = OnboardingView(viewModel: viewModel)
        let viewController = OnboardingViewController(view: view, viewModel: viewModel)
        viewController.delegate = self
        presentingNavigationController?.pushViewController(viewController, animated: animated)
    }

    func showWelcomeScreen(animated: Bool) {
        let viewModel = LiveWelcomeViewModel(
            temporaryStorage: dependencyProvider.temporaryStorage
        )
        let view = WelcomeView(viewModel: viewModel)
        let viewController = WelcomeViewController(view: view, viewModel: viewModel)
        viewController.delegate = self
        presentingNavigationController?.pushViewController(viewController, animated: animated)
    }
}
