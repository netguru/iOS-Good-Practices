//
//  CurrencyDetailsViewModel.swift
//  SwiftUI Interoperability
//

import Foundation
import SwiftUI

// MARK: CurrencyDetailsViewModel

/// An abstraction describing a View Model for an application initial view.
protocol CurrencyDetailsViewModel: BackwardsNavigableViewModel {}

// MARK: DefaultCurrencyDetailsViewModel

/// A default implementation of CurrencyDetailsViewModel.
class LiveCurrencyDetailsViewModel: ObservableObject, CurrencyDetailsViewModel {

    // MARK: Public Properties

    /// - SeeAlso: BackwardsNavigableViewModel.onBackwardNavigationRequested
    var onBackwardNavigationRequested: (() -> Void)?

    /// A view configuration.
    @Published var currencyDetailsViewConfiguration: CurrencyDetailsViewConfiguration

    // MARK: Initializers

    /// A default CurrencyDetailsViewModel initializer.
    /// 
    /// - Parameter details: currency details.
    init(details: CurrencyDetails) {
        let url = URL(string: details.logo)
        currencyDetailsViewConfiguration = CurrencyDetailsViewConfiguration(
            title: details.symbol,
            subtitle: details.name,
            description: details.description,
            tags: details.tags,
            iconLink: url
        )
    }
}
