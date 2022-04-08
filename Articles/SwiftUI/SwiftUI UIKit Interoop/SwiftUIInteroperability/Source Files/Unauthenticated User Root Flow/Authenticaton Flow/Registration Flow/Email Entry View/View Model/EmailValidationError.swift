//
//  EmailValidationError.swift
//  SwiftUI Interoperability
//

import Foundation

// MARK: Validation errors

/// Errors describing issues related to validation process.
enum EmailValidationError: LocalizableError, Equatable {

    /// Invalid text length error.
    case empty

    /// Invalid email error.
    case invalidEmail

    /// SeeAlso: LocalizableError.localizedDescription
    var localizedDescription: String {
        switch self {
        case .empty:
            return "Email is too short"
        case .invalidEmail:
            return "This is not a valid email"
        }
    }
}
