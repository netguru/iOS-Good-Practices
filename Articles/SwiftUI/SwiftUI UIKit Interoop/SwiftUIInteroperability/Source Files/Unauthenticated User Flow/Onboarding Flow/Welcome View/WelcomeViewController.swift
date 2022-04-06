//
//  WelcomeViewController.swift
//  SwiftUI Interoperability
//

import UIKit
import SwiftUI

// MARK: WelcomeViewControllerDelegate

/// A welcome view controller delegate.
protocol WelcomeViewControllerDelegate: AnyObject {

    /// Triggered when welcome view controller needs to be taken off display.
    ///
    /// - Parameter viewController: a view controller.
    func welcomeViewControllerDidFinish(_ viewController: UIViewController)
}

// MARK: WelcomeViewController

class WelcomeViewController<Content>: UIHostingController<Content> where Content: View {

    /// A delegate.
    weak var delegate: WelcomeViewControllerDelegate?

    /// A view model.
    unowned var viewModel: WelcomeViewModel

    /// A default WelcomeViewController initializer.
    ///
    /// - Parameters:
    ///   - view: a view to be shown.
    ///   - viewModel: a view model.
    required init(view: Content, viewModel: WelcomeViewModel) {
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
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

// MARK: Implementation details

private extension WelcomeViewController {

    func setupViewModelCallbacks() {
        viewModel.onNavigationAwayFromViewRequested = { [unowned self] in
            delegate?.welcomeViewControllerDidFinish(self)
        }
    }
}
