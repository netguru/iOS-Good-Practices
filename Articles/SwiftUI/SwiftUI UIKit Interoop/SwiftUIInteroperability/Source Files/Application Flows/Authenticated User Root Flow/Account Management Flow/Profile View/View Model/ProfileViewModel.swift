//
//  ProfileViewModel.swift
//  SwiftUI Interoperability
//

import Foundation
import SwiftUI

// MARK: ProfileViewModel

/// An abstraction describing a View Model for an application initial view.
protocol ProfileViewModel: NavigableViewModel {}

// MARK: DefaultProfileViewModel

/// A default implementation of ProfileViewModel.
class DefaultProfileViewModel: ObservableObject, ProfileViewModel {

    // MARK: Public Properties

    /// - SeeAlso: NavigableViewModel.onNavigationAwayFromViewRequested
    var onNavigationAwayFromViewRequested: (() -> Void)?

    ///
    @Published var profile: String = ""

    ///
    @Published private(set) var profileError: LocalizableError?

    // MARK: Private Properties

    // MARK: Initializers

    /// A default ProfileViewModel initializer.
    init() {}

    // MARK: Public methods
}

// MARK: Implementation details

private extension DefaultProfileViewModel {}
