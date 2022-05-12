//
//  PasswordValidator.swift
//  SwiftUI Interoperability
//

import Foundation

/// A validator for password.
final class PasswordValidator: Validator {

    private let predicate = NSPredicate(format: "SELF MATCHES %@", Constants.pattern)

    /// SeeAlso: TextFieldValidator.validate()
    func validate(value: String?) -> LocalizableError? {
        guard let password = value else {
            return PasswordValidationError.tooShort
        }

        return predicate.evaluate(with: password) ? nil : PasswordValidationError.invalid
    }
}

private extension PasswordValidator {

    enum Constants {
        /// Minimum 8 characters, 1 upper, 1 lowercase, 1 digit, 1 special character.
        static let pattern = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$!%*?&#])[A-Za-z\\dd$@$!%*?&#]{8,}"
    }
}
