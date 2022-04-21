//
//  FakeAppDataCache.swift
//  SwiftUI Interoperability
//

import Foundation
import Mimus

@testable import SwiftUIInteroperability

final class FakeAppDataCache: AppDataCache, Mock {

    var storage = Storage()

    var simulatedStorage = [CacheKey: Any]()

    func store(_ object: Any, forKey key: CacheKey) {
        recordCall(withIdentifier: "store", arguments: [object, key])
    }

    func retrieveObject(forKey key: CacheKey) -> Any? {
        recordCall(withIdentifier: "retrieveObject", arguments: [key])
        return simulatedStorage[key]
    }

    func removeObject(forKey key: CacheKey) {
        recordCall(withIdentifier: "removeObject", arguments: [key])
    }

    func retrieveAndRemoveObject(forKey key: CacheKey) -> Any? {
        recordCall(withIdentifier: "retrieveAndRemoveObject", arguments: [key])
        return simulatedStorage[key]
    }

    func clear() {
        recordCall(withIdentifier: "clear")
    }
}
