//
//  FakeLocalStorage.swift
//  SwiftUI Interoperability
//

import Foundation
import Mimus

@testable import SwiftUIInteroperability

final class FakeLocalStorage: LocalStorage, Mock {

    var storage = Storage()

    var simulatedValues = [String: Any]()

    func string(forKey defaultName: String) -> String? {
        recordCall(withIdentifier: "string", arguments: [defaultName])
        return simulatedValues[defaultName] as? String
    }

    func data(forKey defaultName: String) -> Data? {
        recordCall(withIdentifier: "data", arguments: [defaultName])
        return simulatedValues[defaultName] as? Data
    }

    func integer(forKey defaultName: String) -> Int {
        recordCall(withIdentifier: "integer", arguments: [defaultName])
        return simulatedValues[defaultName] as? Int ?? 0
    }

    func float(forKey defaultName: String) -> Float {
        0.0
    }

    func double(forKey defaultName: String) -> Double {
        0.0
    }

    func object(forKey defaultName: String) -> Any? {
        nil
    }

    func bool(forKey defaultName: String) -> Bool {
        recordCall(withIdentifier: "bool", arguments: [defaultName])
        return simulatedValues[defaultName] as? Bool ?? false
    }

    func dictionary(forKey defaultName: String) -> [String: Any]? {
        recordCall(withIdentifier: "dictionary", arguments: [defaultName])
        return simulatedValues[defaultName] as? [String: Any] ?? [:]
    }

    func set(_ value: Any?, forKey defaultName: String) {
        recordCall(withIdentifier: "set", arguments: [value, defaultName])
        simulatedValues[defaultName] = value
    }

    func removeObject(forKey defaultName: String) {
        recordCall(withIdentifier: "removeObject", arguments: [defaultName])
    }

    func synchronize() -> Bool {
        false
    }
}
