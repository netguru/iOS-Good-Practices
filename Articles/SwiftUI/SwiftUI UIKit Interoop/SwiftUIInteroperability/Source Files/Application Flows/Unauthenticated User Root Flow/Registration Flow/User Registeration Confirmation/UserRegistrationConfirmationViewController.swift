//
//  UserRegistrationConfirmationViewController.swift
//  SwiftUI Interoperability
//

import SwiftUI
import UIKit

// MARK: UserRegistrationConfirmationViewControllerDelegate

protocol UserRegistrationConfirmationViewControllerDelegate: AnyObject {

    /// Notifies delegate when the view is ready to be taken off navigation stack.
    ///
    /// - Parameter viewController: a view controller.
    func userRegistrationConfirmationViewControllerDidFinish(_ viewController: UIViewController)
}

// MARK: UserRegistrationConfirmationViewController

final class UserRegistrationConfirmationViewController<Content>: UIHostingController<Content> where Content: View {

    // MARK: Public Properties

    weak var delegate: UserRegistrationConfirmationViewControllerDelegate?

    /// A view model.
    unowned var viewModel: UserRegistrationConfirmationViewModel

    // MARK: Private Properties

    // MARK: Initializers

    /// A default UserRegistrationConfirmationViewController initializer.
    ///
    /// - Parameters:
    ///   - view: a SwiftUI view.
    ///   - viewModel: a view model.
    required init(view: Content, viewModel: UserRegistrationConfirmationViewModel) {
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
    }
}

// MARK: Implementation details

private extension UserRegistrationConfirmationViewController {

    func setupViewModelCallbacks() {
        viewModel.onNavigationAwayFromViewRequested = { [unowned self] in
            delegate?.userRegistrationConfirmationViewControllerDidFinish(self)
        }
    }
}
