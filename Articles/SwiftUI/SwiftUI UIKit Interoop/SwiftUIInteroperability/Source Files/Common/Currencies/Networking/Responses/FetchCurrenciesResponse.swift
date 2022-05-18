//
//  FetchCurrenciesResponse.swift
//  SwiftUI Interoperability
//

import Foundation

// An abstraction describing network response containing cryptocurrencies.
struct FetchCurrenciesResponse: Codable, Equatable {
    let data: [Currency]
}
