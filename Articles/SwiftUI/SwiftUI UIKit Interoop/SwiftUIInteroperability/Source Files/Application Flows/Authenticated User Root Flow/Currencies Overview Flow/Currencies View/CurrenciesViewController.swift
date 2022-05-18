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
    /// - Parameters:
    ///   - viewController: a view controller.
    ///   - details: a currency details.
    func currenciesViewController(_ viewController: UIViewController, didRequestShowingCurrencyDetails details: CurrencyDetails)
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

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchCurrencies()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
}

// MARK: Implementation details

private extension CurrenciesViewController {

    func setupViewModelCallbacks() {
        viewModel.onCurrencyDetailsViewRequested = { [unowned self] currencyDetails in
            delegate?.currenciesViewController(self, didRequestShowingCurrencyDetails: currencyDetails)
        }
    }
}
