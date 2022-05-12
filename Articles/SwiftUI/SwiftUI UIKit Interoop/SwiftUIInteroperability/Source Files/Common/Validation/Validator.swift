//
//  Validator.swift
//  SwiftUI Interoperability
//

import Foundation

/// An abstraction describing a validator for a provided value.
protocol Validator: AnyObject {

    /// Validates provided value.
    ///
    /// - Parameter value: a value to be verified.
    /// - Returns: a validation error.
    func validate(value: String?) -> LocalizableError?
}
