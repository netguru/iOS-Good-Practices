//
//  CurrenciesViewModel.swift
//  SwiftUI Interoperability
//

import Foundation
import SwiftUI

// MARK: CurrenciesViewModel

/// An abstraction describing a View Model for an application initial view.
protocol CurrenciesViewModel: NavigableViewModel {}

// MARK: DefaultCurrenciesViewModel

/// A default implementation of CurrenciesViewModel.
class DefaultCurrenciesViewModel: ObservableObject, CurrenciesViewModel {

    // MARK: Public Properties

    /// - SeeAlso: NavigableViewModel.onNavigationAwayFromViewRequested
    var onNavigationAwayFromViewRequested: (() -> Void)?

    ///
    @Published var currencies: String = ""

    ///
    @Published private(set) var currenciesError: LocalizableError?

    // MARK: Private Properties

    // MARK: Initializers

    /// A default CurrenciesViewModel initializer.
    init() {}

    // MARK: Public methods
}

// MARK: Implementation details

private extension DefaultCurrenciesViewModel {}
