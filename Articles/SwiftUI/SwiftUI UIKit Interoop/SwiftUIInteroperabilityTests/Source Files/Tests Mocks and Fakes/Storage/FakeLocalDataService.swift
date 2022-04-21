//
//  FakeLocalDataService.swift
//  SwiftUI Interoperability
//

import Foundation
import Mimus

@testable import SwiftUIInteroperability

final class FakeLocalDataService: LocalDataService, Mock {
    var storage = Mimus.Storage()
    var simulatedHasFinishedOnboarding: Bool?
    var simulatedRegisteredUser: UserAuthenticationInfo?

    var hasFinishedOnboarding: Bool {
        get {
            simulatedHasFinishedOnboarding ?? false
        }
        set {
            recordCall(withIdentifier: "hasFinishedOnboarding", arguments: [newValue])
            simulatedHasFinishedOnboarding = newValue
        }
    }

    var registeredUser: UserAuthenticationInfo? {
        get {
            simulatedRegisteredUser
        }
        set {
            recordCall(withIdentifier: "registeredUser", arguments: [newValue])
            simulatedRegisteredUser = newValue
        }
    }
}
