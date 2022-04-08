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
}

// MARK: DefaultLocalDataService

/// Default local data service used for storing data.
final class DefaultLocalDataService: LocalDataService {

    /// Keys for saving the data.
    enum Keys: String {
        case hasFinishedOnboardingKey
        case currentUser
    }

    /// UserDefaults used for storing data.
    let localStorage: LocalStorage

    // MARK: Properties

    /// Indicating whether app has runned before.
    var hasFinishedOnboarding: Bool {
        get {
            localStorage.bool(forKey: Keys.hasFinishedOnboardingKey.rawValue)
        }
        set {
            localStorage.set(newValue, forKey: Keys.hasFinishedOnboardingKey.rawValue)
        }
    }

    /// A user that has currently signed up.
    var currentUser: UserAuthenticationInfo? {
        get {
            if let userData = localStorage.data(forKey: Keys.currentUser.rawValue) {
                return try? UserAuthenticationInfo(from: userData)
            }
            return nil
        }
        set {
            localStorage.set(newValue, forKey: Keys.currentUser.rawValue)
        }
    }

    // MARK: Initializer

    /// Initializing the service.
    /// - Parameter localStorage: localStorage used for storing data.
    init(localStorage: LocalStorage = UserDefaults.standard) {
        self.localStorage = localStorage
    }
}
