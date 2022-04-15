//
//  DashboardViewModel.swift
//  SwiftUI Interoperability
//

import Foundation
import SwiftUI

// MARK: DashboardViewModel

/// An abstraction describing a View Model for an application initial view.
protocol DashboardViewModel: NavigableViewModel {}

// MARK: DefaultDashboardViewModel

/// A default implementation of DashboardViewModel.
class DefaultDashboardViewModel: ObservableObject, DashboardViewModel {

    // MARK: Public Properties

    /// - SeeAlso: NavigableViewModel.onNavigationAwayFromViewRequested
    var onNavigationAwayFromViewRequested: (() -> Void)?

    ///
    @Published var dashboard: String = ""

    ///
    @Published private(set) var dashboardError: LocalizableError?

    // MARK: Private Properties

    // MARK: Initializers

    /// A default DashboardViewModel initializer.
    init() {}

    // MARK: Public methods
}

// MARK: Implementation details

private extension DefaultDashboardViewModel {}
