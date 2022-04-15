//
//  CurrenciesViewController.swift
//  SwiftUI Interoperability
//

import SwiftUI
import UIKit

// MARK: CurrenciesViewControllerDelegate

protocol CurrenciesViewControllerDelegate: AnyObject {

    /// Notifies delegate when the view is ready to be taken off navigation stack.
    ///
    /// - Parameter viewController: a view controller.
    func currenciesViewControllerDidFinish(_ viewController: UIViewController)
}

// MARK: CurrenciesViewController

final class CurrenciesViewController<Content>: UIHostingController<Content> where Content: View {

    // MARK: Public Properties

    weak var delegate: CurrenciesViewControllerDelegate?

    /// A view model.
    unowned var viewModel: CurrenciesViewModel

    // MARK: Private Properties

    // MARK: Initializers

    /// A default CurrenciesViewController initializer.
    ///
    /// - Parameters:
    ///   - view: a SwiftUI view.
    ///   - viewModel: a view model.
    required init(view: Content, viewModel: CurrenciesViewModel) {
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

private extension CurrenciesViewController {

    func setupViewModelCallbacks() {
        viewModel.onNavigationAwayFromViewRequested = { [unowned self] in
            delegate?.currenciesViewControllerDidFinish(self)
        }
    }
}
