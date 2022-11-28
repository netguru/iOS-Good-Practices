//
//  CurrencyDetailsViewConfiguration.swift
//  SwiftUI Interoperability
//

import Foundation

/// A structure describing currencies details view configuration.
struct CurrencyDetailsViewConfiguration {
    let title: String
    let subtitle: String
    let description: String
    let tags: [String]?
    let iconLink: URL?
}

extension CurrencyDetailsViewConfiguration {

    static let empty = CurrencyDetailsViewConfiguration(
        title: "",
        subtitle: "",
        description: "",
        tags: nil,
        iconLink: nil
    )
}
