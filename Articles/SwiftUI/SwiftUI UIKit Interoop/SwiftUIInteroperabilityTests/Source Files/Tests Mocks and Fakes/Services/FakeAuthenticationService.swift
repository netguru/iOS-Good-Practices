//
//  FakeAuthenticationService.swift
//  SwiftUI Interoperability
//

import Foundation
import Mimus

@testable import SwiftUIInteroperability

final class FakeAuthenticationService: AuthenticationService, Mock {
    var storage = Mimus.Storage()
    var loggedInUser: UserInfo? {
        simulatedLoggedInUser
    }

    private var simulatedLoggedInUser: UserInfo?
    private var authenticationCompletion: ((Result<UserInfo, UserAuthenticationError>) -> Void)?
    private var logoutCompletion: ((Bool) -> Void)?

    func authenticate(userAuthenticationInfo: UserAuthenticationInfo, completion: ((Result<UserInfo, UserAuthenticationError>) -> Void)?) {
        recordCall(withIdentifier: "authenticate", arguments: [userAuthenticationInfo])
        authenticationCompletion = completion
    }

    func logout(completion: ((Bool) -> Void)?) {
        recordCall(withIdentifier: "logout")
        logoutCompletion = completion
    }
}

extension FakeAuthenticationService {

    func simulateAuthenticationSuccess(userInfo: UserInfo) {
        authenticationCompletion?(.success(userInfo))
    }

    func simulateAuthenticationFailure(error: UserAuthenticationError) {
        authenticationCompletion?(.failure(error))
    }

    func simulateLogoutCompleted(status: Bool) {
        logoutCompletion?(status)
    }
}
