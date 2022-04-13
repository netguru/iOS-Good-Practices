//
//  PasswordValidationError.swift
//  SwiftUI Interoperability
//

import Foundation

// MARK: Validation errors

/// Errors describing issues related to validation process.
enum PasswordValidationError: LocalizableError, Equatable {

    /// Invalid text length error.
    case tooShort

    /// Invalid email error.
    case invalid

    /// Passwords are not matching.
    case notMatching

    /// SeeAlso: LocalizableError.localizedDescription
    var localizedDescription: String {
        switch self {
        case .tooShort:
            return "Password is too short"
        case .invalid:
            return "The password must contain at least 8 characters, 1 capital letter, 1 digit and 1 special character"
        case .notMatching:
            return "Passwords must match"
        }
    }
}
