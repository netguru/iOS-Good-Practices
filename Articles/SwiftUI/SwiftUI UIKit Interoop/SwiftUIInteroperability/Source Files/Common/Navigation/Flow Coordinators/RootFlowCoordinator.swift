//
//  RootFlowCoordinator.swift
//  SwiftUI Interoperability
//

import UIKit

/// An enumeration containing names of Root Flow Coordinators.
enum RootFlowCoordinatorName: String, CaseIterable {
    case unauthenticatedUser, authenticatedUser
}

/// An abstraction providing access to current root flow coordinator.
protocol CurrentRootFlowCoordinatorProvider: AnyObject {

    /// A currently running root flow coordinator.
    var currentRootFlowCoordinator: RootFlowCoordinator? { get }
}

/// An abstraction describing Root Flow Coordinator Delegate.
/// Informs a delegate when a given root flow is finished.
protocol RootFlowCoordinatorDelegate: AnyObject {

    /// Executed when flow is finished.
    ///
    /// - Parameter rootFlowCoordinator: root flow coordinator.
    func rootFlowCoordinatorDidFinish(_ rootFlowCoordinator: RootFlowCoordinator)
}

/// An abstraction describing Root Flow Coordinator.
/// A Flow Coordinator executed on application root.
protocol RootFlowCoordinator: AnyObject {

    /// A root flow coordinator delegate.
    var delegate: RootFlowCoordinatorDelegate? { get set }

    /// A View Controller being the root of a flow, usually a UINavigationController.
    var rootViewController: UIViewController { get }

    /// Root flow distinct name.
    var name: String { get }

    /// Currently presented flow coordinator.
    var currentFlowCoordinator: FlowCoordinator? { get }

    /// Starts a root flow.
    func start()
}

// MARK: Default Implementation

extension RootFlowCoordinator {

    /// A convenience method to notify delegate that the root flow has finished.
    func finish() {
        delegate?.rootFlowCoordinatorDidFinish(self)
    }
}
