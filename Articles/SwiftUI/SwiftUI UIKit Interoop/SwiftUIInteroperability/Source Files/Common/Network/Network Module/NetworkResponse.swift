//
//  NetworkResponse.swift
//  SwiftUI Interoperability
//

import Foundation

/// A networking response.
struct NetworkResponse {

    /// An unparsed, raw data representing a received response.
    let data: Data?

    /// A network response object.
    let networkResponse: HTTPURLResponse
}

extension NetworkResponse {

    /// A convenience method decoding a network response data into a provided response structure type.
    ///
    /// - Parameter responseStructureType: a response structure type.
    /// - Returns: a decoding result.
    func decode<T: Decodable>(responseStructureType: T.Type) -> Result<T, NetworkError> {
        guard let data = data else {
            return .failure(NetworkError.noData)
        }
        do {
            let responseObject = try JSONDecoder().decode(responseStructureType, from: data)
            return .success(responseObject)
        } catch {
            return .failure(NetworkError.improperResponse)
        }
    }
}
