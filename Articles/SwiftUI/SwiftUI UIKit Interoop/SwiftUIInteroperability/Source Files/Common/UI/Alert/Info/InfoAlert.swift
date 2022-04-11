//
//  InfoAlert.swift
//  SwiftUI Interoperability
//

import UIKit

/// Describes the info alert builder logic.
protocol InfoAlert: AnyObject {
    /// Presents an alert view controller on the specified view controller.
    ///
    /// - Parameters:
    ///     - title: A title to be shown on the alert view controller.
    ///     - message: A message to be shown on the alert view controller.
    ///     - buttonTitle: A title on the acceptance button.
    ///     - acceptanceCompletion: The block to execute after the presentation finishes and user click on a button.
    func show(
        title: String,
        message: String?,
        buttonTitle: String,
        acceptanceCompletion: (() -> Void)?
    )
}

// MARK: Default Implementation

extension InfoAlert {

    /// - SeeAlso: `InfoAlert.show`
    func show(
        title: String,
        message: String?
    ) {
        show(title: title, message: message, buttonTitle: "OK", acceptanceCompletion: nil)
    }
}

/// Constructing and presenting informational alert.
final class DefaultInfoAlert: InfoAlert {

    /// An alert controller configured by the object.
    private(set) var alertController: UIAlertController?

    private let viewControllerProvider: VisibleViewControllerProvider

    init(viewControllerProvider: VisibleViewControllerProvider) {
        self.viewControllerProvider = viewControllerProvider
    }

    /// - SeeAlso: `InfoAlert.show`
    func show(
        title: String,
        message: String?,
        buttonTitle: String,
        acceptanceCompletion: (() -> Void)?
    ) {
        let okAction = UIAlertAction(
            title: buttonTitle,
            style: .default,
            handler: { _ in
                acceptanceCompletion?()
            }
        )
        alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController?.addAction(okAction)
        viewControllerProvider.visibleViewController.present(alertController!, animated: true, completion: nil)
    }

    /// - SeeAlso: `DismissibleAlert.dismiss()`
    func dismiss(animated: Bool) {
        guard let alertController = alertController else {
            return
        }
        alertController.dismiss(animated: true) { [unowned self] in
            self.alertController = nil
        }
    }
}
