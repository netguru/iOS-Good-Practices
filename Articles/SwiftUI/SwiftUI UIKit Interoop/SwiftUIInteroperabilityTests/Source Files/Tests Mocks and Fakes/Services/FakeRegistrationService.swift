//
//  FakeRegistrationService.swift
//  SwiftUI Interoperability
//

import Foundation
import Mimus

@testable import SwiftUIInteroperability

final class FakeRegistrationService: RegistrationService, Mock {
    var storage = Mimus.Storage()

    private var completion: ((Result<UserInfo, UserRegistrationError>) -> Void)?

    func register(userAuthenticationInfo: UserAuthenticationInfo, completion: ((Result<UserInfo, UserRegistrationError>) -> Void)?) {
        recordCall(withIdentifier: "register", arguments: [userAuthenticationInfo])
        self.completion = completion
    }
}

extension FakeRegistrationService {

    func simulateRegistrationSuccessful(userInfo: UserInfo) {
        completion?(.success(userInfo))
    }

    func simulateRegistrationFailed(error: UserRegistrationError) {
        completion?(.failure(error))
    }
}
