//
//  UserRegistrationError.swift
//  SwiftUI Interoperability
//

import Foundation

enum UserRegistrationError: LocalizableError, Equatable {

    ///
    case failed

    ///
    case emailTaken

    /// SeeAlso: LocalizableError.localizedDescription
    var localizedDescription: String {
        switch self {
        case .failed:
            return "Registration failed. Try again later."
        case .emailTaken:
            return "Email already taken. Try another one."
        }
    }
}
