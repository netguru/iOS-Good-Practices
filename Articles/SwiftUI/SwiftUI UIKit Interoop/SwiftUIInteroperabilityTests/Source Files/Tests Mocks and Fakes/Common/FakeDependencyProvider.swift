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

    var permanentStorage: LocalDataService {
        fakeLocalDataService
    }

    var temporaryStorage: AppDataCache {
        fakeAppDataCache
    }

    var authenticationService: AuthenticationService {
        fakeAuthenticationService
    }

    var registrationService: RegistrationService {
        fakeRegistrationService
    }

    var presentableHUD: PresentableHud {
        fakePresentableHud
    }

    var infoAlert: InfoAlert {
        fakeInfoAlert
    }

    var acceptanceAlert: AcceptanceAlert {
        fakeAcceptanceAlert
    }
}
