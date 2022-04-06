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
final class DefaultRootFlowCoordinatorFactory: RootFlowCoordinatorFactory {

    // MARK: Properties

    /// A reference to the application Dependency Provider.
    /// SeeAlso: RootFlowCoordinatorFactory.dependencyProvider.
    private(set) unowned var dependencyProvider: DependencyProvider

    // MARK: Initializers

    /// A default initializer for DefaultRootFlowCoordinatorFactory.
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
        UnauthenticatedUserRootFlowCoordinator(dependencyProvider: dependencyProvider)
        // TODO: Implement support for other root flows.
    }
}
