//
//  AppDelegate.swift
//  SwiftUI Interoperability
//

import UIKit
import SwiftUI

/// Main application delegate
class AppDelegate: UIResponder {

    // MARK: Properties

    /// Main app window controller
    let windowController: WindowController

    // MARK: Initializers

    /// Default AppDelegate initializer
    override init() {
        let dependencyProvider = DefaultDependencyProvider()
        let rootViewController = UIHostingController(rootView: RootView())
        let viewControllersTransitionsCoordinator = DefaultViewControllersTransitionsCoordinator(
            containerViewController: rootViewController
        )
        windowController = DefaultWindowController(
            dependencyProvider: dependencyProvider,
            rootFlowCoordinatorFactory: DefaultRootFlowCoordinatorFactory(dependencyProvider: dependencyProvider),
            viewControllersTransitionsCoordinator: viewControllersTransitionsCoordinator,
            rootViewController: rootViewController
        )
        dependencyProvider.setup(windowController: windowController)
    }
}

// MARK: UIApplicationDelegate

extension AppDelegate: UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("AppDelegate:didFinishLaunchingWithOptions")
        windowController.makeAndPresentInitialViewController()
        windowController.startInitialApplicationFlow()
        return true
    }
}

// MARK: Implementation details

private extension AppDelegate {

    var dependencyProvider: DependencyProvider {
        windowController.dependencyProvider
    }
}
