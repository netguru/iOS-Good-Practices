//
//  DecodableExtensions.swift
//  SwiftUI Interoperability
//

import Foundation

extension Decodable {

    /// A convenience initializer.
    /// Initializes an object implementing Decodable protocol from a provided object.
    ///
    /// - Parameter from: an object to initiate from.
    /// - Throws: a conversion error.
    init(from object: Any) throws {
        let data = try JSONSerialization.data(withJSONObject: object, options: .prettyPrinted)
        let decoder = JSONDecoder()
        self = try decoder.decode(Self.self, from: data)
    }
}
