//
//  CurrenciesListCellData.swift
//  SwiftUI Interoperability
//

import Foundation

/// A structure describing data presented in the currency list cell.
struct CurrenciesListCellData: Equatable, Identifiable {
    let id: Int
    let name: String
    let description: String
    let price: String
}
