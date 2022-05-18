//
//  CurrenciesViewState.swift
//  SwiftUI Interoperability
//

import Foundation

/// A structure describing a currencies view state.
enum CurrenciesViewState: Equatable {
    case cached([CurrenciesListCellData])
    case noData
    case loading
    case error(LocalizableError)
    case loaded([CurrenciesListCellData])

    static func == (lhs: CurrenciesViewState, rhs: CurrenciesViewState) -> Bool {
        switch (lhs, rhs) {
        case (.noData, .noData),
             (.loading, .loading):
            return true
        case let (.error(e1), .error(e2)):
            return e1.localizedDescription == e2.localizedDescription
        case let (.loaded(c1), .loaded(c2)):
            return c1 == c2
        case let (.cached(c1), .cached(c2)):
            return c1 == c2
        default:
            return false
        }
    }
}
