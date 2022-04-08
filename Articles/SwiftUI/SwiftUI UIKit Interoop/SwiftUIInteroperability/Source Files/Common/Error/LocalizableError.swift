//
//  LocalizableError.swift
//  SwiftUI Interoperability
//

import Foundation

/// An abstraction describing a localizable error.
/// Provides error code and localizable description for more convenient handling.
protocol LocalizableError: Error {

    /// A localized description of an error.
    var localizedDescription: String { get }
}
