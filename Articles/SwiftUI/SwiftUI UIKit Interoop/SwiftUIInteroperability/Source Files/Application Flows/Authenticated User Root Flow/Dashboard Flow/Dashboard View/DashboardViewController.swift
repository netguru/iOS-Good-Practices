//
//  DashboardViewController.swift
//  SwiftUI Interoperability
//

import SwiftUI
import UIKit

// MARK: DashboardViewControllerDelegate

protocol DashboardViewControllerDelegate: AnyObject {

    /// Notifies delegate when the view is ready to be taken off navigation stack.
    ///
    /// - Parameter viewController: a view controller.
    func dashboardViewControllerDidFinish(_ viewController: UIViewController)
}

// MARK: DashboardViewController

final class DashboardViewController<Content>: UIHostingController<Content> where Content: View {

    // MARK: Public Properties

    weak var delegate: DashboardViewControllerDelegate?

    /// A view model.
    unowned var viewModel: DashboardViewModel

    // MARK: Private Properties

    // MARK: Initializers

    /// A default DashboardViewController initializer.
    ///
    /// - Parameters:
    ///   - view: a SwiftUI view.
    ///   - viewModel: a view model.
    required init(view: Content, viewModel: DashboardViewModel) {
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

private extension DashboardViewController {

    func setupViewModelCallbacks() {
        viewModel.onNavigationAwayFromViewRequested = { [unowned self] in
            delegate?.dashboardViewControllerDidFinish(self)
        }
    }
}
