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

// MARK: DefaultDependencyProvider

final class DefaultDependencyProvider {

    let defaultLocalDataService: DefaultLocalDataService
    let defaultAppDataCache: DefaultAppDataCache
    let defaultAuthenticationService: DefaultAuthenticationService
    let defaultRegistrationService: DefaultRegistrationService

    private unowned var windowController: WindowController?
    private var defaultPresentableHUD: DefaultPresentableHud?
    private var defaultInfoAlert: DefaultInfoAlert?
    private var defaultAcceptanceAlert: DefaultAcceptanceAlert?

    /// A default initializer.
    init() {
        defaultLocalDataService = DefaultLocalDataService(localStorage: UserDefaults.standard)
        defaultAppDataCache = DefaultAppDataCache()
        defaultAuthenticationService = DefaultAuthenticationService(localStorage: defaultLocalDataService)
        defaultRegistrationService = DefaultRegistrationService(localStorage: defaultLocalDataService)
    }

    /// Sets up the provider with data that cannot be obtained at app start.
    ///
    /// - Parameter windowController: an application main window controller.
    func setup(windowController: WindowController) {
        self.windowController = windowController
        defaultPresentableHUD = DefaultPresentableHud(viewProvider: windowController)
        defaultInfoAlert = DefaultInfoAlert(viewControllerProvider: windowController)
        defaultAcceptanceAlert = DefaultAcceptanceAlert(viewControllerProvider: windowController)
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

    var registrationService: RegistrationService {
        defaultRegistrationService
    }

    var presentableHUD: PresentableHud {
        defaultPresentableHUD!
    }

    var infoAlert: InfoAlert {
        defaultInfoAlert!
    }

    var acceptanceAlert: AcceptanceAlert {
        defaultAcceptanceAlert!
    }
}
