//
//  UserRegistrationConfirmationViewModel.swift
//  SwiftUI Interoperability
//

import Foundation
import SwiftUI

// MARK: UserRegistrationConfirmationViewModel

/// An abstraction describing a View Model for an application initial view.
protocol UserRegistrationConfirmationViewModel: NavigableViewModel {}

// MARK: DefaultUserRegistrationConfirmationViewModel

/// A default implementation of UserRegistrationConfirmationViewModel.
class DefaultUserRegistrationConfirmationViewModel: ObservableObject, UserRegistrationConfirmationViewModel {

    // MARK: Public Properties

    /// - SeeAlso: NavigableViewModel.onNavigationAwayFromViewRequested
    var onNavigationAwayFromViewRequested: (() -> Void)?

    /// A registered email.
    @Published var email: String = ""

    // MARK: Initializers

    private let appDataCache: AppDataCache

    /// A default UserRegistrationConfirmationViewModel initializer.
    init(
        appDataCache: AppDataCache
    ) {
        self.appDataCache = appDataCache
        email = appDataCache.retrieveAndRemoveObject(forKey: .selectedEmail) as? String ?? ""
    }
}
