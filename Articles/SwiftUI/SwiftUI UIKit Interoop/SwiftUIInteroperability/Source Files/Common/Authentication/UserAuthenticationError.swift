//
//  UserAuthenticationError.swift
//  SwiftUI Interoperability
//

import Foundation

enum UserAuthenticationError: LocalizableError, Equatable {

    ///
    case failed

    /// SeeAlso: LocalizableError.localizedDescription
    var localizedDescription: String {
        switch self {
        case .failed:
            return "Email or password does not match"
        }
    }
}
