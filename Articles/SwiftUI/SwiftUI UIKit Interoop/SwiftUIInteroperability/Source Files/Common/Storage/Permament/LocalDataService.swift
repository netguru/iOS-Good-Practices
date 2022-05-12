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
}

// MARK: LiveLocalDataService

/// Default local data service used for storing data.
final class LiveLocalDataService: LocalDataService {

    /// Keys for saving the data.
    enum Keys: String {
        case hasFinishedOnboardingKey
        case registeredUser
    }

    /// UserDefaults used for storing data.
    let localStorage: LocalStorage

    // MARK: Properties

    /// - SeeAlso: LocalDataService.hasFinishedOnboarding
    var hasFinishedOnboarding: Bool {
        get {
            localStorage.bool(forKey: Keys.hasFinishedOnboardingKey.rawValue)
        }
        set {
            localStorage.set(newValue, forKey: Keys.hasFinishedOnboardingKey.rawValue)
        }
    }

    /// - SeeAlso: LocalDataService.registeredUser
    var registeredUser: UserAuthenticationInfo? {
        get {
            if let userData = localStorage.data(forKey: Keys.registeredUser.rawValue) {
                return userData.decoded(into: UserAuthenticationInfo.self)
            }
            return nil
        }
        set {
            localStorage.set(newValue.data, forKey: Keys.registeredUser.rawValue)
        }
    }

    // MARK: Initializer

    /// Initializing the service.
    /// - Parameter localStorage: localStorage used for storing data.
    init(localStorage: LocalStorage = UserDefaults.standard) {
        self.localStorage = localStorage
    }
}
