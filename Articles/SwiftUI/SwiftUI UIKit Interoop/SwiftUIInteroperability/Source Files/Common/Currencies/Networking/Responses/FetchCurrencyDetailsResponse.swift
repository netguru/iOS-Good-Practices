//
//  FetchCurrencyDetailsResponse.swift
//  SwiftUI Interoperability
//

import Foundation

// An abstraction describing a cryptocurrency details network response.
struct FetchCurrencyDetailsResponse: Codable, Equatable {
    let data: [String: CurrencyDetails]
}

extension FetchCurrencyDetailsResponse {

    /// A convenience property for currency details.
    var details: CurrencyDetails {
        data.values.first!
    }
}
