//
//  CurrencyDetailsViewController.swift
//  SwiftUI Interoperability
//

import SwiftUI
import UIKit

// MARK: CurrencyDetailsViewControllerDelegate

protocol CurrencyDetailsViewControllerDelegate: AnyObject {

    /// Notifies delegate when the view is ready to be taken off navigation stack.
    ///
    /// - Parameter viewController: a view controller.
    func currencyDetailsViewControllerDidRequestBackwardsNavigation(_ viewController: UIViewController)
}

// MARK: CurrencyDetailsViewController

final class CurrencyDetailsViewController<Content>: UIHostingController<Content> where Content: View {

    // MARK: Public Properties

    weak var delegate: CurrencyDetailsViewControllerDelegate?

    /// A view model.
    unowned var viewModel: CurrencyDetailsViewModel

    // MARK: Private Properties

    // MARK: Initializers

    /// A default CurrencyDetailsViewController initializer.
    ///
    /// - Parameters:
    ///   - view: a SwiftUI view.
    ///   - viewModel: a view model.
    required init(view: Content, viewModel: CurrencyDetailsViewModel) {
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

private extension CurrencyDetailsViewController {

    func setupViewModelCallbacks() {
        viewModel.onBackwardNavigationRequested = { [unowned self] in
            delegate?.currencyDetailsViewControllerDidRequestBackwardsNavigation(self)
        }
    }
}
