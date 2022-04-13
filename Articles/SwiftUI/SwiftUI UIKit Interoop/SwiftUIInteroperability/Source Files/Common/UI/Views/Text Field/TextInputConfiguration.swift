//
//  TextInputConfiguration.swift
//  SwiftUI Interoperability
//

import UIKit
import SwiftUI

/// A text input configuration.
struct TextInputConfiguration {

    /// A textfield type.
    let type: TextInputType

    /// An input name (to manage focus).
    let name: String

    /// A textfield prompt.
    let prompt: String
}

extension TextInputConfiguration {

    static func makeEmailTextInputConfiguration(
        fieldName: String = TextInputType.email.rawValue,
        prompt: String = TextInputType.email.suggestedPrompt
    ) -> TextInputConfiguration {
        TextInputConfiguration(type: .email, name: fieldName, prompt: prompt)
    }

    static func makePasswordTextInputConfiguration(
        fieldName: String = TextInputType.password.rawValue,
        prompt: String = TextInputType.password.suggestedPrompt
    ) -> TextInputConfiguration {
        TextInputConfiguration(type: .email, name: fieldName, prompt: prompt)
    }
}

/// Text input type enumeration.
enum TextInputType: String {
    case email, password
}

extension TextInputType {

    /// A keyboard type.
    var keyboardType: UIKeyboardType {
        switch self {
        case .email:
            return .emailAddress
        case .password:
            return .default
        }
    }

    /// A suggested prompt/
    var suggestedPrompt: String {
        switch self {
        case .email:
            return "Enter email address"
        case .password:
            return "Enter password"
        }
    }
}
