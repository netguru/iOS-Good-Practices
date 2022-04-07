//
//  EmailValidator.swift
//  SwiftUI Interoperability
//

import Foundation

/// A validator for email addresses.
final class EmailValidator: Validator {

    private let predicate = NSPredicate(format: "SELF MATCHES %@", Constants.pattern)

    /// SeeAlso: TextFieldValidator.validate()
    func validate(value: String?) -> LocalizableError? {
        guard let email = value else {
            return EmailValidationError.empty
        }

        return predicate.evaluate(with: email) ? nil : EmailValidationError.invalidEmail
    }
}

private extension EmailValidator {

    enum Constants {
        static let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    }
}
