//
//  CurrencyDetail.swift
//  SwiftUI Interoperability
//

import Foundation

/// A structure describing a cryptocurrency details.
struct CurrencyDetails: Equatable, Codable {
    let id: Int
    let name: String
    let symbol: String
    let logo: String
    let slug: String
    let tags: [String]?
}
