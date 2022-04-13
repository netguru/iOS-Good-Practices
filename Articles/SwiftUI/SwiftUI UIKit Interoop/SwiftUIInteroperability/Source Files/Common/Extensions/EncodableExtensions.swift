//
//  EncodableExtensions.swift
//  SwiftUI Interoperability
//

import Foundation

extension Encodable {

    /// Encodes an object to data.
    var data: Data? {
        try? JSONEncoder().encode(self)
    }
}

extension Data {

    /// Attempts to decode a encoded object to a provided structure.
    ///
    /// - Parameter type: a type to decode an object to.
    /// - Returns: a decoded object.
    func decoded<T: Decodable>(into type: T.Type) -> T? {
        try? JSONDecoder().decode(type, from: self)
    }
}
