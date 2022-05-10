//
//  AppDataCache.swift
//  SwiftUI Interoperability
//

import Foundation

enum CacheKey: String, Equatable {
    case selectedAuthenticationFlow
    case selectedEmail
    case authenticatedUser
}

/// An abstraction defining data cache for the app.
protocol AppDataCache {

    /// Stores given object under a given key.
    ///
    /// - Parameters:
    ///     - object: an object to store.
    ///     - key: a key to store the object under.
    func store(_ object: Any, forKey key: CacheKey)

    /// Retrieves object for a given key.
    ///
    /// - Parameter key: a key for the object.
    /// - Returns: an object of any type stored in cache or nil.
    func retrieveObject(forKey key: CacheKey) -> Any?

    /// Removes object from cache.
    ///
    /// - Parameter key: a key for the object.
    func removeObject(forKey key: CacheKey)

    /// Retrieves object for a given key and then removes it from the cache.
    ///
    /// - Parameter key: a key for the object.
    /// - Returns: an object of any type stored in cache or nil.
    func retrieveAndRemoveObject(forKey key: CacheKey) -> Any?
}

/// Default implementation of AppDataCache.
final class LiveAppDataCache: AppDataCache {

    private var storage = [CacheKey: Any]()

    /// - SeeAlso: AppDataCache.store(object, key)
    func store(_ object: Any, forKey key: CacheKey) {
        storage[key] = object
    }

    /// - SeeAlso: AppDataCache.retrieveObject(key)
    func retrieveObject(forKey key: CacheKey) -> Any? {
        storage[key]
    }

    /// - SeeAlso: AppDataCache.removeObject(key)
    func removeObject(forKey key: CacheKey) {
        storage.removeValue(forKey: key)
    }

    /// - SeeAlso: AppDataCache.retrieveAndRemoveObject(key)
    func retrieveAndRemoveObject(forKey key: CacheKey) -> Any? {
        let object = retrieveObject(forKey: key)
        removeObject(forKey: key)
        return object
    }

    /// - SeeAlso: AppDataCache.clear()
    func clear() {
        storage.removeAll()
    }
}
