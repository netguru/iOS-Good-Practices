//
//  EmailEntryViewController.swift
//  SwiftUI Interoperability
//

import UIKit
import SwiftUI

// MARK: EmailEntryViewControllerDelegate

/// An email registration view controller delegate.
protocol EmailEntryViewControllerDelegate: AnyObject {

    /// Notifies delegate when the user has entered a correct email.
    ///
    /// - Parameter viewController: a view controller.
    func emailEntryViewControllerDidFinish(_ viewController: UIViewController)

    /// Notifies delegate when user decided to navigate to sign in view.
    ///
    /// - Parameter viewController: a view controller.
    func emailEntryViewControllerDidRequestNavigatingToLogIn(_ viewController: UIViewController)
}

// MARK: EmailEntryViewController

class EmailEntryViewController<Content>: UIHostingController<Content> where Content: View {

    /// A delegate.
    weak var delegate: EmailEntryViewControllerDelegate?

    /// A view model.
    unowned var viewModel: EmailEntryViewModel

    /// A default EmailEntryViewController initializer.
    ///
    /// - Parameters:
    ///   - view: a SwiftUI view.
    ///   - viewModel: a view model.
    required init(view: Content, viewModel: EmailEntryViewModel) {
        self.viewModel = viewModel
        super.init(rootView: view)
        setupViewModelCallbacks()
    }

    override required init(rootView: Content) {
        fatalError("init(rootView:) has not been implemented")
    }

    @objc dynamic required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle events

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
}

// MARK: Implementation details

private extension EmailEntryViewController {

    func setupViewModelCallbacks() {
        viewModel.onNavigationAwayFromViewRequested = { [unowned self] in
            delegate?.emailEntryViewControllerDidFinish(self)
        }
        viewModel.onSignInFlowRequested = { [unowned self] in
            delegate?.emailEntryViewControllerDidRequestNavigatingToLogIn(self)
        }
    }
}
