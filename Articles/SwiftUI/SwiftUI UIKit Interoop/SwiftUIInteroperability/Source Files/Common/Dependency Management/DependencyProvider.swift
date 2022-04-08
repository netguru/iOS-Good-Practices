//
//  DependencyProvider.swift
//  SwiftUI Interoperability
//

import UIKit

// MARK: DependencyProvider

/// An abstraction providing convenient reference to all major app dependencies: storage, notification handlers
protocol DependencyProvider: AnyObject {

    /// An app permanent storage.
    var permanentStorage: LocalDataService { get }

    /// An app temporary storage.
    var temporaryStorage: AppDataCache { get }

    /// An authentication service.
    var authenticationService: AuthenticationService { get }
}

// MARK: DefaultDependencyProvider

final class DefaultDependencyProvider {

    let defaultLocalDataService: DefaultLocalDataService
    let defaultAppDataCache: DefaultAppDataCache
    let defaultAuthenticationService: DefaultAuthenticationService

    private unowned var windowController: WindowController?

    /// A default initializer.
    init() {
        defaultLocalDataService = DefaultLocalDataService(localStorage: UserDefaults.standard)
        defaultAppDataCache = DefaultAppDataCache()
        defaultAuthenticationService = DefaultAuthenticationService(localStorage: defaultLocalDataService)
    }

    /// Sets up the provider with data that cannot be obtained at app start.
    ///
    /// - Parameter windowController: an application main window controller.
    func setup(windowController: WindowController) {
        self.windowController = windowController
    }
}

// MARK: DependencyProvider Extension

extension DefaultDependencyProvider: DependencyProvider {

    var permanentStorage: LocalDataService {
        defaultLocalDataService
    }

    var temporaryStorage: AppDataCache {
        defaultAppDataCache
    }

    var authenticationService: AuthenticationService {
        defaultAuthenticationService
    }
}
