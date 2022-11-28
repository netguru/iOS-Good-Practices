//
//  LocalDataService.swift
//  SwiftUI Interoperability
//

import Foundation

// MARK: LocalDataService

/// Local Service used for storing data.
protocol LocalDataService: AnyObject {

    /// Indicating the user has finished onboarding.
    var hasFinishedOnboarding: Bool { get set }

    /// A user that has currently signed up.
    var registeredUser: UserAuthenticationInfo? { get set }

    /// A cached currencies.
    var currencies: [Currency] { get set }
}

// MARK: LiveLocalDataService

/// Default local data service used for storing data.
final class LiveLocalDataService: LocalDataService {

    /// Keys for saving the data.
    enum Key: String {
        case hasFinishedOnboardingKey
        case registeredUser
        case currencies
    }

    /// UserDefaults used for storing data.
    let localStorage: LocalStorage

    // MARK: Properties

    /// - SeeAlso: LocalDataService.hasFinishedOnboarding
    var hasFinishedOnboarding: Bool {
        get {
            localStorage.bool(forKey: Key.hasFinishedOnboardingKey.rawValue)
        }
        set {
            localStorage.set(newValue, forKey: Key.hasFinishedOnboardingKey.rawValue)
        }
    }

    /// - SeeAlso: LocalDataService.registeredUser
    var registeredUser: UserAuthenticationInfo? {
        get {
            getData(forKey: .registeredUser, decodedInto: UserAuthenticationInfo.self)
        }
        set {
            localStorage.set(newValue.data, forKey: Key.registeredUser.rawValue)
        }
    }

    /// - SeeAlso: LocalDataService.currencies
    var currencies: [Currency] {
        get {
            getData(forKey: .currencies, decodedInto: [Currency].self) ?? []
        }
        set {
            localStorage.set(newValue.data, forKey: Key.currencies.rawValue)
        }
    }

    // MARK: Initializer

    /// Initializing the service.
    /// - Parameter localStorage: localStorage used for storing data.
    init(localStorage: LocalStorage = UserDefaults.standard) {
        self.localStorage = localStorage
    }
}

private extension LiveLocalDataService {

    func getData<T: Decodable>(forKey key: Key, decodedInto type: T.Type) -> T? {
        if let data = localStorage.data(forKey: key.rawValue) {
            return data.decoded(into: type)
        }
        return nil
    }
}
