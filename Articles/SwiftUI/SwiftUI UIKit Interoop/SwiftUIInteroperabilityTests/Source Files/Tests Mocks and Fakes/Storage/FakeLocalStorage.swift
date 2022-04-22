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
        simulatedValues[defaultName] as? String
    }

    func data(forKey defaultName: String) -> Data? {
        simulatedValues[defaultName] as? Data
    }

    func integer(forKey defaultName: String) -> Int {
        simulatedValues[defaultName] as? Int ?? 0
    }

    func bool(forKey defaultName: String) -> Bool {
        simulatedValues[defaultName] as? Bool ?? false
    }

    func set(_ value: Any?, forKey defaultName: String) {
        recordCall(withIdentifier: "set", arguments: [value, defaultName])
    }

    func removeObject(forKey defaultName: String) {
        recordCall(withIdentifier: "removeObject", arguments: [defaultName])
    }

    func synchronize() -> Bool {
        true
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

    func dictionary(forKey defaultName: String) -> [String: Any]? {
        nil
    }
}
