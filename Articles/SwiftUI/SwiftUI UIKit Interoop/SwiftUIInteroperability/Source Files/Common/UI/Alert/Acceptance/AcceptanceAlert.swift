//
//  AcceptanceAlert.swift
//  SwiftUI Interoperability
//

import UIKit

/// An action type for acceptance alert.
enum AcceptanceAlertAction: Equatable {
    case yes, no
}

/// Describes the acceptance alert builder logic.
protocol AcceptanceAlert: AnyObject {
    /// Presents an alert view controller on the specified view controller.
    ///
    /// - Parameters:
    ///     - title: A title to be shown on the alert view controller.
    ///     - message: A message to be shown on the alert view controller.
    ///     - yesActionTitle: A positive button title.
    ///     - noActionTitle: A negative button title.
    ///     - yesActionStyle: A positive button action style.
    ///     - noActionStyle: A negative button action style.
    ///     - completion: The block to execute after the presentation finishes and user click on one of buttons.
    func show(
        title: String,
        message: String?,
        yesActionTitle: String,
        noActionTitle: String,
        yesActionStyle: UIAlertAction.Style,
        noActionStyle: UIAlertAction.Style,
        completion: ((AcceptanceAlertAction) -> Void)?
    )
}

// MARK: Default Implementation

extension AcceptanceAlert {

    /// - SeeAlso: AcceptanceAlert.show(title:message:completion)
    func show(
        title: String,
        message: String?,
        completion: ((AcceptanceAlertAction) -> Void)?
    ) {
        show(
            title: title,
            message: message,
            yesActionTitle: "Yes",
            noActionTitle: "No",
            yesActionStyle: .default,
            noActionStyle: .default,
            completion: completion
        )
    }
}

// MARK: DefaultAcceptanceAlert

/// Constructing and presenting acceptance alert.
final class DefaultAcceptanceAlert: AcceptanceAlert {

    /// An alert controller configured by the object.
    private(set) var alertController: UIAlertController?

    private let viewControllerProvider: VisibleViewControllerProvider
    private var completion: ((AcceptanceAlertAction) -> Void)?

    // MARK: Initializer

    init(viewControllerProvider: VisibleViewControllerProvider) {
        self.viewControllerProvider = viewControllerProvider
    }

    /// - SeeAlso: `AcceptanceAlert.show`
    func show(
        title: String,
        message: String?,
        yesActionTitle: String = "Yes",
        noActionTitle: String = "No",
        yesActionStyle: UIAlertAction.Style = .default,
        noActionStyle: UIAlertAction.Style = .default,
        completion: ((AcceptanceAlertAction) -> Void)?
    ) {
        let yesAction = UIAlertAction(
            title: yesActionTitle,
            style: yesActionStyle,
            handler: { _ in
                completion?(.yes)
            }
        )
        let noAction = UIAlertAction(
            title: noActionTitle,
            style: noActionStyle,
            handler: { _ in
                completion?(.no)
            }
        )
        alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController?.addAction(noAction)
        alertController?.addAction(yesAction)
        self.completion = completion
        viewControllerProvider.visibleViewController.present(alertController!, animated: true, completion: nil)
    }
}
