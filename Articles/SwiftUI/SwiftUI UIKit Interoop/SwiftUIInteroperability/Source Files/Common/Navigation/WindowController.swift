//
//  WindowController.swift
//  SwiftUI Interoperability
//

import UIKit
import SwiftUI

/// Describes an object handling main application Window.
protocol WindowController: AnyObject {

    /// App Dependencies Provider
    var dependencyProvider: DependencyProvider { get }

    /// Creates the main UIWindow of the application.
    func makeAndPresentInitialViewController()

    /// Starts initial application flow.
    func startInitialApplicationFlow()
}

/// An object handling main application Window.
/// Is responsible for setting up and displaying initial application root flow.
/// When the flow is done, triggers creation and starting of a new root flow.
final class DefaultWindowController: WindowController {

    // MARK: Properties

    /// A factory creating root flow to be presented next.
    let rootFlowCoordinatorFactory: RootFlowCoordinatorFactory

    /// A factory creating transition between root flow coordinators (current and next) roots.
    let viewControllersTransitionsCoordinator: ViewControllersTransitionsCoordinator

    /// A dependency provider.
    let dependencyProvider: DependencyProvider

    /// A root view controller.
    let rootViewController: UIViewController

    /// Current application window.
    private(set) var window: UIWindow?

    /// Currently presented root flow
    private(set) var currentRootFlowCoordinator: RootFlowCoordinator?

    // MARK: Initializers

    init(
        dependencyProvider: DependencyProvider,
        rootFlowCoordinatorFactory: RootFlowCoordinatorFactory,
        viewControllersTransitionsCoordinator: ViewControllersTransitionsCoordinator,
        rootViewController: UIViewController
    ) {
        self.dependencyProvider = dependencyProvider
        self.rootFlowCoordinatorFactory = rootFlowCoordinatorFactory
        self.viewControllersTransitionsCoordinator = viewControllersTransitionsCoordinator
        self.rootViewController = rootViewController
    }

    // MARK: Public methods

    /// Creates the main UIWindow of the application.
    /// Starts initial application root flow
    func makeAndPresentInitialViewController() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        self.window = window
    }

    /// - SeeAlso: `WindowController:startInitialApplicationFlow`
    func startInitialApplicationFlow() {
        presentNextRootFlowCoordinator(animationType: .none)
    }
}

// MARK: RootFlowCoordinatorDelegate

extension DefaultWindowController: RootFlowCoordinatorDelegate {

    /// SeeAlso: `RootFlowCoordinatorDelegate.rootFlowCoordinatorDidFinish(RootFlowCoordinator)`
    func rootFlowCoordinatorDidFinish(_ flowCoordinator: RootFlowCoordinator) {
        presentNextRootFlowCoordinator(animationType: .forward)
    }
}

// MARK: Private extension

private extension DefaultWindowController {

    func presentNextRootFlowCoordinator(animationType: ViewControllerTransitionAnimation) {
        let coordinator = rootFlowCoordinatorFactory.makeNextRootFlowCoordinator()
        presentRootFlowCoordinator(coordinator, animationType: animationType)
    }

    func presentRootFlowCoordinator(_ flowCoordinator: RootFlowCoordinator, animationType: ViewControllerTransitionAnimation) {
        flowCoordinator.rootFlowCoordinatorDelegate = self
        flowCoordinator.start()
        viewControllersTransitionsCoordinator.transition(toViewController: flowCoordinator.rootViewController, animationType: animationType)
        currentRootFlowCoordinator = flowCoordinator
    }
}
