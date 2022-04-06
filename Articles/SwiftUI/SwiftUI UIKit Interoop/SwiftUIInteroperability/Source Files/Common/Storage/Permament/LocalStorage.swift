//
//  LocalStorage.swift
//  SwiftUI Interoperability
//

import Foundation

// MARK: LocalStorage

/// A convenience wrapper around UserDefaults used for local storage description.
protocol LocalStorage {

    /// Retrieves a string value stored under a provided key.
    ///
    /// - Parameter defaultName: key.
    /// - Returns: value.
    func string(forKey defaultName: String) -> String?

    /// Retrieves a data value stored under a provided key.
    ///
    /// - Parameter defaultName: key.
    /// - Returns: value.
    func data(forKey defaultName: String) -> Data?

    /// Retrieves an integer value stored under a provided key.
    ///
    /// - Parameter defaultName: key.
    /// - Returns: value.
    func integer(forKey defaultName: String) -> Int

    /// Retrieves a float value stored under a provided key.
    ///
    /// - Parameter defaultName: key.
    /// - Returns: value.
    func float(forKey defaultName: String) -> Float

    /// Retrieves a double value stored under a provided key.
    ///
    /// - Parameter defaultName: key.
    /// - Returns: value.
    func double(forKey defaultName: String) -> Double

    /// Retrieves an object value stored under a provided key.
    ///
    /// - Parameter defaultName: key.
    /// - Returns: value.
    func object(forKey defaultName: String) -> Any?

    /// Retrieves a boolean value stored under a provided key.
    ///
    /// - Parameter defaultName: key.
    /// - Returns: value.
    func bool(forKey defaultName: String) -> Bool

    /// Retrieves a dictionary object stored under a provided key.
    /// - Parameter defaultName: key.
    /// - Returns: object.
    func dictionary(forKey defaultName: String) -> [String: Any]?

    /// Sets a value under a provided key.
    ///
    /// - Parameters:
    ///   - value: value to store.
    ///   - defaultName: key.
    func set(_ value: Any?, forKey defaultName: String)

    /// Removed value stored under a provided key.
    ///
    /// - Parameter defaultName: key.
    func removeObject(forKey defaultName: String)

    /// Immediately synchronizes values storage.
    ///
    /// - Returns: synchronisation status.
    func synchronize() -> Bool
}

// MARK: UserDefaults extension

extension UserDefaults: LocalStorage {}
