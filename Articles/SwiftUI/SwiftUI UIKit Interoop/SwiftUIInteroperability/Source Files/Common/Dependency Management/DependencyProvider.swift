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

    /// A registration service.
    var registrationService: RegistrationService { get }

    /// A presentable HUD.
    var presentableHUD: PresentableHud { get }

    /// An information alert.
    var infoAlert: InfoAlert { get }

    /// An acceptance alert.
    var acceptanceAlert: AcceptanceAlert { get }
}

// MARK: LiveDependencyProvider

final class LiveDependencyProvider {

    let liveLocalDataService: LiveLocalDataService
    let liveAppDataCache: LiveAppDataCache
    let liveAuthenticationService: LiveAuthenticationService
    let liveRegistrationService: LiveRegistrationService

    private unowned var windowController: WindowController?
    private var livePresentableHUD: LivePresentableHud?
    private var liveInfoAlert: LiveInfoAlert?
    private var liveAcceptanceAlert: LiveAcceptanceAlert?

    /// A default initializer.
    init() {
        liveLocalDataService = LiveLocalDataService(localStorage: UserDefaults.standard)
        liveAppDataCache = LiveAppDataCache()
        liveAuthenticationService = LiveAuthenticationService(
            localStorage: liveLocalDataService,
            appDataCache: liveAppDataCache
        )
        liveRegistrationService = LiveRegistrationService(localStorage: liveLocalDataService)
    }

    /// Sets up the provider with data that cannot be obtained at app start.
    ///
    /// - Parameter windowController: an application main window controller.
    func setup(windowController: WindowController) {
        self.windowController = windowController
        livePresentableHUD = LivePresentableHud(viewProvider: windowController)
        liveInfoAlert = LiveInfoAlert(viewControllerProvider: windowController)
        liveAcceptanceAlert = LiveAcceptanceAlert(viewControllerProvider: windowController)
    }
}

// MARK: DependencyProvider Extension

extension LiveDependencyProvider: DependencyProvider {

    var permanentStorage: LocalDataService {
        liveLocalDataService
    }

    var temporaryStorage: AppDataCache {
        liveAppDataCache
    }

    var authenticationService: AuthenticationService {
        liveAuthenticationService
    }

    var registrationService: RegistrationService {
        liveRegistrationService
    }

    var presentableHUD: PresentableHud {
        livePresentableHUD!
    }

    var infoAlert: InfoAlert {
        liveInfoAlert!
    }

    var acceptanceAlert: AcceptanceAlert {
        liveAcceptanceAlert!
    }
}
