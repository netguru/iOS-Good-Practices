//
//  CurrenciesViewModel.swift
//  SwiftUI Interoperability
//

import Foundation
import SwiftUI

// MARK: CurrenciesViewModel

/// An abstraction describing a View Model for an application initial view.
protocol CurrenciesViewModel: AnyObject {

    /// A current view state.
    var viewState: CurrenciesViewState { get }

    /// A callback to be triggered when the user has requested seeing currency details.
    var onCurrencyDetailsViewRequested: ((CurrencyDetails) -> Void)? { get set }

    /// Starts fetching currencies.
    func fetchCurrencies()

    /// Selects a currency.
    ///
    /// - Parameter id: currency id.
    func selectCurrency(id: Int)
}

// MARK: LiveCurrenciesViewModel

/// A default implementation of CurrenciesViewModel.
class LiveCurrenciesViewModel: ObservableObject, CurrenciesViewModel {

    // MARK: Public Properties

    /// - SeeAlso: NavigableViewModel.onCurrencyDetailsViewRequested
    var onCurrencyDetailsViewRequested: ((CurrencyDetails) -> Void)?

    /// - SeeAlso: CurrenciesViewModel.viewState
    @Published var viewState: CurrenciesViewState = .noData

    // MARK: Private Properties

    private let currenciesService: CurrenciesService
    private let presentableHUD: PresentableHud
    private let infoAlert: InfoAlert

    // MARK: Initializers

    /// A default CurrenciesViewModel initializer.
    ///
    /// - Parameter currenciesService: a currencies service.
    /// - Parameter presentableHUD: a presentable HUD.
    /// - Parameter infoAlert: an information alert.
    init(
        currenciesService: CurrenciesService,
        presentableHUD: PresentableHud,
        infoAlert: InfoAlert
    ) {
        self.currenciesService = currenciesService
        self.presentableHUD = presentableHUD
        self.infoAlert = infoAlert
        viewState = currenciesService.currencies.isEmpty ? .noData : .cached(cachedCurrenciesCellModels)
    }

    /// - SeeAlso: CurrenciesViewModel.fetchCurrencies()
    func fetchCurrencies() {
        viewState = currenciesService.currencies.isEmpty ? .loading : .cached(cachedCurrenciesCellModels)
        currenciesService.refreshCurrencies { [unowned self] result in
            switch result {
            case let .success(currencies):
                let cellModels = currencies.toCurrencyCellViewModels()
                viewState = cellModels.isEmpty ? .noData : .loaded(cellModels)
            case let .failure(error):
                viewState = .error(error)
            }
        }
    }

    /// - SeeAlso: CurrenciesViewModel.selectCurrency(id:)
    func selectCurrency(id: Int) {
        presentableHUD.show(animated: true)
        currenciesService.getCurrency(id: id) { [unowned self] result in
            switch result {
            case let .success(currencyInfo):
                onCurrencyDetailsViewRequested?(currencyInfo)
            case let .failure(error):
                showAlert(errorMessage: error.localizedDescription)
            }
            presentableHUD.hide(animated: true)
        }
    }
}

// MARK: Implementation details

private extension LiveCurrenciesViewModel {

    var cachedCurrenciesCellModels: [CurrenciesListCellData] {
        currenciesService.currencies.toCurrencyCellViewModels()
    }

    func showAlert(errorMessage: String) {
        infoAlert.show(
            title: "Something went wrong...",
            message: errorMessage
        )
    }
}

extension Array where Element == Currency {

    func toCurrencyCellViewModels() -> [CurrenciesListCellData] {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return map {
            CurrenciesListCellData(
                id: $0.id,
                name: $0.symbol,
                description: $0.name,
                price: formatter.string(from: $0.quote.USD.price as NSNumber) ?? "---"
            )
        }
    }
}
