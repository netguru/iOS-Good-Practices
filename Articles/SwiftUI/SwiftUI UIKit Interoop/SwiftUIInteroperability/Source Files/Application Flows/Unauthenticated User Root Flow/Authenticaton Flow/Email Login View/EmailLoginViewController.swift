//
//  EmailLoginViewController.swift
//  SwiftUI Interoperability
//

import UIKit
import SwiftUI

// MARK: EmailLoginViewControllerDelegate

/// An email login view controller delegate.
protocol EmailLoginViewControllerDelegate: AnyObject {

    /// Notifies delegate when the user has entered a correct email.
    ///
    /// - Parameter viewController: a view controller.
    func emailLoginViewControllerDidFinish(_ viewController: UIViewController)

    /// Notifies delegate when user decided to navigate to registration view.
    ///
    /// - Parameter viewController: a view controller.
    func emailLoginViewControllerDidRequestNavigatingToRegistration(_ viewController: UIViewController)
}

// MARK: EmailLoginViewController

class EmailLoginViewController<Content>: UIHostingController<Content> where Content: View {

    /// A delegate.
    weak var delegate: EmailLoginViewControllerDelegate?

    /// A view model.
    unowned var viewModel: EmailLoginViewModel

    /// A default EmailLoginViewController initializer.
    ///
    /// - Parameters:
    ///   - view: a SwiftUI view.
    ///   - viewModel: a view model.
    required init(view: Content, viewModel: EmailLoginViewModel) {
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

private extension EmailLoginViewController {

    func setupViewModelCallbacks() {
        viewModel.onNavigationAwayFromViewRequested = { [unowned self] in
            delegate?.emailLoginViewControllerDidFinish(self)
        }
        viewModel.onRegistrationFlowRequested = { [unowned self] in
            delegate?.emailLoginViewControllerDidRequestNavigatingToRegistration(self)
        }
    }
}
