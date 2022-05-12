//
//  FlowCoordinator.swift
//  SwiftUI Interoperability
//

import UIKit

/// An abstraction describing Flow Coordinator.
protocol FlowCoordinator: AnyObject {

    /// A navigation controller presenting the flow.
    var presentingNavigationController: UINavigationController? { get }

    /// Flow distinct name.
    var name: String { get }

    /// Starts the flow.
    ///
    /// - Parameter animated: perform animation when showing flow initial screen.
    func start(animated: Bool)

    /// Finishes the flow.
    func finish()
}
