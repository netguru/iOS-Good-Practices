//
//  NetworkError.swift
//  IdentityPinningTest
//
//  Created by Jolanta Zakrzewska on 10/08/2022.
//

import Foundation

enum NetworkError: Error {
    case clientError(Error)
    case serverError(statusCode: Int)
    case dataError
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case let .clientError(error):
            return "Encountered error: \(error.localizedDescription)"
        case let .serverError(statusCode):
            return "Encountered server error (\(statusCode))"
        case .dataError:
            return "No data was returned from API"
        }
    }
}
