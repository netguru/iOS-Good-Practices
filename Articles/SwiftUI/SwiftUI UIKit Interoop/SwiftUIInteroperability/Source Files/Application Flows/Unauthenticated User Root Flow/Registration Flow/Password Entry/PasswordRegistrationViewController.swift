//
//  PasswordRegistrationViewController.swift
//  SwiftUI Interoperability
//

import SwiftUI
import UIKit

// MARK: PasswordRegistrationViewControllerDelegate

protocol PasswordRegistrationViewControllerDelegate: AnyObject {

    /// Notifies delegate when the view is ready to be taken off navigation stack.
    ///
    /// - Parameter viewController: a view controller.
    func passwordRegistrationViewControllerDidFinish(_ viewController: UIViewController)

    /// Notifies delegate when the view requested to go back in navigation stack.
    ///
    /// - Parameter viewController: a view controller.
    func passwordRegistrationViewControllerDidRequestBackwardsNavigation(_ viewController: UIViewController)
}

// MARK: PasswordRegistrationViewController

final class PasswordRegistrationViewController<Content>: UIHostingController<Content> where Content: View {

    // MARK: Public Properties

    weak var delegate: PasswordRegistrationViewControllerDelegate?

    /// A view model.
    unowned var viewModel: PasswordRegistrationViewModel

    // MARK: Initializers

    /// A default PasswordRegistrationViewController initializer.
    ///
    /// - Parameters:
    ///   - view: a SwiftUI view.
    ///   - viewModel: a view model.
    required init(view: Content, viewModel: PasswordRegistrationViewModel) {
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

private extension PasswordRegistrationViewController {

    func setupViewModelCallbacks() {
        viewModel.onNavigationAwayFromViewRequested = { [unowned self] in
            delegate?.passwordRegistrationViewControllerDidFinish(self)
        }
        viewModel.onBackwardNavigationRequested = { [unowned self] in
            delegate?.passwordRegistrationViewControllerDidRequestBackwardsNavigation(self)
        }
    }
}
