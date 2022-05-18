//
//  NetworkError.swift
//  SwiftUI Interoperability
//

import Foundation

/// An enumeration representing a network error.
enum NetworkError: LocalizableError {
    case notFound
    case timedOut
    case invalidRequest(message: String?)
    case requestParsingFailed
    case improperResponse
    case serverError
    case unauthorized
    case forbidden
    case unknown
    case noConnection
    case noData

    init?(code: Int, message: String?) {
        switch code {
        case 404:
            self = .notFound
        case 403:
            self = .forbidden
        case 401:
            self = .unauthorized
        case 408:
            self = .timedOut
        case 400...499:
            self = .invalidRequest(message: message)
        case 500...599:
            self = .serverError
        case -1009:
            self = .noConnection
        default:
            return nil
        }
    }

    /// - SeeAlso: LocalizableError.localizedDescription
    var localizedDescription: String {
        switch self {
        case .noConnection: return "No internet connection"
        default: return "An error has occurred"
        }
    }
}
