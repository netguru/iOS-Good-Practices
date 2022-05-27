//
//  VisibleViewProvider.swift
//  SwiftUI Interoperability
//

import UIKit

// MARK: VisibleViewProvider

/// A Protocol providing a reference to currently displayed top view.
protocol VisibleViewProvider: AnyObject {

    /// Provides a reference to currently visible View.
    var visibleView: UIView { get }
}

/// A Protocol providing a reference to currently displayed top view controller.
protocol VisibleViewControllerProvider: VisibleViewProvider {

    /// Provides a reference to currently visible ViewController.
    var visibleViewController: UIViewController { get }
}

// MARK: UIViewController implementation

extension UIViewController: VisibleViewControllerProvider {

    /// SeeAlso: VisibleViewControllerProvider.visibleViewController
    var visibleViewController: UIViewController {
        self
    }

    /// SeeAlso: VisibleViewProvider.visibleView
    var visibleView: UIView {
        view
    }
}

// MARK: UIView implementation

extension UIView: VisibleViewProvider {

    /// SeeAlso: VisibleViewProvider.visibleView
    var visibleView: UIView {
        self
    }
}
