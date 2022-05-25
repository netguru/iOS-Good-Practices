//
//  FakeDependencyProvider.swift
//  SwiftUI Interoperability
//

import Foundation
import Mimus

@testable import SwiftUIInteroperability

final class FakeDependencyProvider: DependencyProvider, Mock {
    var storage = Mimus.Storage()
    let fakeLocalDataService = FakeLocalDataService()
    let fakeAppDataCache = FakeAppDataCache()
    let fakeAuthenticationService = FakeAuthenticationService()
    let fakeRegistrationService = FakeRegistrationService()
    let fakePresentableHud = FakePresentableHud()
    let fakeInfoAlert = FakeInfoAlert()
    let fakeAcceptanceAlert = FakeAcceptanceAlert()
    let fakeAuthenticationTokenProvider = FakeAuthenticationTokenProvider()
    let fakeCurrenciesService = FakeCurrenciesService()

    private var simulatedInjectedDependencies = [String: Any]()

    init() {
        register(fakeLocalDataService, for: LocalDataService.self)
        register(fakeAppDataCache, for: AppDataCache.self)
        register(fakeAuthenticationService, for: AuthenticationService.self)
        register(fakeRegistrationService, for: RegistrationService.self)
        register(fakePresentableHud, for: PresentableHud.self)
        register(fakeInfoAlert, for: InfoAlert.self)
        register(fakeAcceptanceAlert, for: AcceptanceAlert.self)
        register(fakeAuthenticationTokenProvider, for: AuthenticationTokenProvider.self)
        register(fakeCurrenciesService, for: CurrenciesService.self)
    }

    func register<T>(_ dependency: T, for type: T.Type) {
        recordCall(withIdentifier: "register", arguments: [String(describing: type)])
        simulatedInjectedDependencies[String(describing: type.self)] = dependency
    }

    func resolve<T>() -> T {
        simulatedInjectedDependencies[String(describing: T.self)] as! T
    }
}
