//
//  Currency.swift
//  SwiftUI Interoperability
//

import Foundation

/// A structure describing a cryptocurrency.
struct Currency: Equatable, Codable {
    let id: Int
    let symbol: String
    let name: String
    let slug: String
    let quote: CurrencyQuotes
}

extension Currency {

    /// A cryptocurrency quote.
    struct CurrencyQuote: Equatable, Codable {
        let price: Double
    }

    /// A cryptocurrency quotes.
    struct CurrencyQuotes: Equatable, Codable {
        let USD: CurrencyQuote
    }
}
