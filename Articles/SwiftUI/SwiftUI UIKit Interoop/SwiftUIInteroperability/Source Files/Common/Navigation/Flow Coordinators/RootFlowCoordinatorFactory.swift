//
//  RootFlowCoordinatorFactory.swift
//  SwiftUI Interoperability
//

import UIKit

/// An abstraction describing a factory responsible for creating next Root Flow Coordinator to be presented.
protocol RootFlowCoordinatorFactory: AnyObject {

    /// Creates next root flow coordinator to be presented.
    ///
    /// - Returns: root flow coordinator.
    func makeNextRootFlowCoordinator() -> RootFlowCoordinator
}

/// A default implementation of RootFlowCoordinatorFactory.
/// SeeAlso: RootFlowCoordinatorFactory.
final class LiveRootFlowCoordinatorFactory: RootFlowCoordinatorFactory {

    // MARK: Properties

    /// A reference to the application Dependency Provider.
    /// SeeAlso: RootFlowCoordinatorFactory.dependencyProvider.
    private(set) unowned var dependencyProvider: DependencyProvider

    // MARK: Initializers

    /// A default initializer for LiveRootFlowCoordinatorFactory.
    ///
    /// - Parameters:
    ///   - dependencyProvider: a reference to the application Dependency Provider.
    init(
        dependencyProvider: DependencyProvider
    ) {
        self.dependencyProvider = dependencyProvider
    }

    // MARK: Public methods

    /// Creates Root Flow Coordinator to be presented.
    /// SeeAlso: RootFlowCoordinatorFactory.makeNextRootFlowCoordinator()
    ///
    /// - Returns: a root flow to be presented.
    func makeNextRootFlowCoordinator() -> RootFlowCoordinator {
        let storage: AppDataCache = dependencyProvider.resolve()
        if storage.retrieveObject(forKey: .authenticatedUser) != nil {
            return AuthenticatedUserRootFlowCoordinator(dependencyProvider: dependencyProvider)
        } else {
            return UnauthenticatedUserRootFlowCoordinator(dependencyProvider: dependencyProvider)
        }
    }
}
