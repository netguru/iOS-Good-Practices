//
//  DependencyProvider.swift
//  SwiftUI Interoperability
//

import UIKit
import Keys

// MARK: DependencyProvider

/// An abstraction providing convenient reference to all major app dependencies: storage, notification handlers
protocol DependencyProvider: AnyObject {

    /// Registers a dependency under a provided protocol / type.
    ///
    /// - Parameters:
    ///   - dependency: a dependency.
    ///   - type: a type under which a dependency will be registered.
    func register<T>(_ dependency: T, for type: T.Type)

    /// Resolves a dependency, based on a provided type.
    ///
    /// - Returns: a resolved dependency.
    func resolve<T>() -> T
}

// MARK: LiveDependencyProvider

final class LiveDependencyProvider {
    private var dependencies = [String: Any]()

    /// Sets up the provider.
    ///
    /// - Parameter windowController: an application main window controller.
    func setup(windowController: WindowController) {

        //  App secrets and providers:
        let appSecrets = ApplicationSecrets(cocoapodKeys: SwiftUIInteroperabilityKeys())
        let liveAuthenticationTokenProvider = LiveAuthenticationTokenProvider(appSecretsProvider: appSecrets)
        register(liveAuthenticationTokenProvider, for: AuthenticationTokenProvider.self)

        //  Network module:
        let liveNetworkModule = LiveNetworkModule(
            requestBuilder: LiveRequestBuilder(baseURL: URL(string: appSecrets.baseUrl)!),
            urlSession: URLSession(configuration: .default),
            actions: [
                AddAuthenticationTokenNetworkModuleAction(authenticationTokenProvider: liveAuthenticationTokenProvider),
                AddJsonContentTypeNetworkModuleAction()
            ]
        )
        register(liveNetworkModule, for: NetworkModule.self)

        //  Services:
        let liveAppDataCache = LiveAppDataCache()
        let liveLocalDataService = LiveLocalDataService(localStorage: UserDefaults.standard)
        let liveAuthenticationService = LiveAuthenticationService(
            localStorage: liveLocalDataService,
            appDataCache: liveAppDataCache
        )
        let liveCurrenciesService = LiveCurrenciesService(
            networkController: LiveCurrenciesNetworkController(networkModule: liveNetworkModule),
            localDataService: liveLocalDataService
        )
        register(liveLocalDataService, for: LocalDataService.self)
        register(liveAppDataCache, for: AppDataCache.self)
        register(liveAuthenticationService, for: AuthenticationService.self)
        register(LiveRegistrationService(localStorage: liveLocalDataService), for: RegistrationService.self)
        register(liveCurrenciesService, for: CurrenciesService.self)

        //  UI handlers:
        register(LivePresentableHud(viewProvider: windowController), for: PresentableHud.self)
        register(LiveInfoAlert(viewControllerProvider: windowController), for: InfoAlert.self)
        register(LiveAcceptanceAlert(viewControllerProvider: windowController), for: AcceptanceAlert.self)
    }
}

// MARK: DependencyProvider Extension

extension LiveDependencyProvider: DependencyProvider {

    /// - SeeAlso: DependencyProvider.register(dependency:type:)
    func register<T>(_ dependency: T, for type: T.Type) {
        let id = String(describing: type)
        dependencies[id] = dependency
    }

    /// - SeeAlso: DependencyProvider.resolve()
    func resolve<T>() -> T {
        let id = String(describing: T.self)
        if let dependency = dependencies[id] as? T {
            return dependency
        } else {
            fatalError("No dependency found for \(id)! must register a dependency before resolve.")
        }
    }
}
