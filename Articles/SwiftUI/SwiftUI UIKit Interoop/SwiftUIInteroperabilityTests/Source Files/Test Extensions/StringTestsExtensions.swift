//
//  StringTestsExtensions.swift
//  SwiftUI Interoperability
//

import Foundation

extension String {

    /// Attempts to convert JSON string to a dictionary.
    var dictionary: [String: Any]? {
        guard let data = data(using: String.Encoding.utf8) else {
            return nil
        }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]
    }
}
