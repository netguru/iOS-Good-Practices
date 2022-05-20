//
//  FakeAuthenticationTokenProvider.swift
//  SwiftUI Interoperability
//

import Foundation
import Mimus

@testable import SwiftUIInteroperability

final class FakeAuthenticationTokenProvider: AuthenticationTokenProvider, Mock {
    var storage = Mimus.Storage()
    var simulatedAccessToken: String?

    var accessToken: String {
        simulatedAccessToken ?? ""
    }
}
