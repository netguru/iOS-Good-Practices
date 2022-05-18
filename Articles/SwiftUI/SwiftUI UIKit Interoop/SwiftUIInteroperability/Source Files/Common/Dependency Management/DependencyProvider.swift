//
//  DependencyProvider.swift
//  SwiftUI Interoperability
//

import UIKit
import Keys

// MARK: DependencyProvider

/// An abstraction providing convenient reference to all major app dependencies: storage, notification handlers
protocol DependencyProvider: AnyObject {

    /// An authentication token provider.
    var authenticationTokenProvider: AuthenticationTokenProvider { get }

    /// A cryptocurrencies service.
    var currenciesService: CurrenciesService { get }

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
    let liveAuthenticationTokenProvider: LiveAuthenticationTokenProvider
    let liveNetworkModule: LiveNetworkModule
    let liveCurrenciesService: LiveCurrenciesService

    private unowned var windowController: WindowController?
    private var livePresentableHUD: LivePresentableHud?
    private var liveInfoAlert: LiveInfoAlert?
    private var liveAcceptanceAlert: LiveAcceptanceAlert?

    /// A default initializer.
    init() {
        let appSecrets = ApplicationSecrets(cocoapodKeys: SwiftUIInteroperabilityKeys())
        liveAuthenticationTokenProvider = LiveAuthenticationTokenProvider(appSecretsProvider: appSecrets)
        liveLocalDataService = LiveLocalDataService(localStorage: UserDefaults.standard)
        liveAppDataCache = LiveAppDataCache()

        liveNetworkModule = LiveNetworkModule(
            requestBuilder: LiveRequestBuilder(baseURL: URL(string: appSecrets.baseUrl)!),
            urlSession: URLSession(configuration: .default),
            actions: [
                AddAuthenticationTokenNetworkModuleAction(authenticationTokenProvider: liveAuthenticationTokenProvider),
                AddJsonContentTypeNetworkModuleAction()
            ]
        )

        //  Services:
        liveAuthenticationService = LiveAuthenticationService(
            localStorage: liveLocalDataService,
            appDataCache: liveAppDataCache
        )
        liveRegistrationService = LiveRegistrationService(localStorage: liveLocalDataService)
        liveCurrenciesService = LiveCurrenciesService(
            networkController: LiveCurrenciesNetworkController(networkModule: liveNetworkModule),
            localDataService: liveLocalDataService
        )
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

    var currenciesService: CurrenciesService {
        liveCurrenciesService
    }

    var infoAlert: InfoAlert {
        liveInfoAlert!
    }

    var acceptanceAlert: AcceptanceAlert {
        liveAcceptanceAlert!
    }

    var authenticationTokenProvider: AuthenticationTokenProvider {
        liveAuthenticationTokenProvider
    }
}
