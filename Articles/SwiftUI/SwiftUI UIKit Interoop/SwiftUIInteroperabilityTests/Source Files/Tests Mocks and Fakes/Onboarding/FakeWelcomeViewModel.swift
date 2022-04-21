//
//  FakeWelcomeViewModel.swift
//  SwiftUI Interoperability
//

import Foundation
import Mimus

@testable import SwiftUIInteroperability

final class FakeWelcomeViewModel: DefaultWelcomeViewModel, Mock {
    var storage = Mimus.Storage()

    override func requestSignUp() {
        recordCall(withIdentifier: "requestSignUp")
    }

    override func requestLogin() {
        recordCall(withIdentifier: "requestLogin")
    }
}
