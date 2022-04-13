//
//  EmailValidationError.swift
//  SwiftUI Interoperability
//

import Foundation

// MARK: Validation errors

/// Errors describing issues related to validation process.
enum EmailValidationError: LocalizableError, Equatable {

    /// Invalid text length error.
    case tooShort

    /// Invalid email error.
    case invalid

    /// SeeAlso: LocalizableError.localizedDescription
    var localizedDescription: String {
        switch self {
        case .tooShort:
            return "Email is too short"
        case .invalid:
            return "This is not a valid email"
        }
    }
}
