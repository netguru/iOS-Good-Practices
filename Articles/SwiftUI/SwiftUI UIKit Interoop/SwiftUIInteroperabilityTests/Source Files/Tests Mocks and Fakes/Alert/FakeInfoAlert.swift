//
//  FakeInfoAlert.swift
//  SwiftUI Interoperability
//

import Foundation
import Mimus

@testable import SwiftUIInteroperability

final class FakeInfoAlert: InfoAlert, Mock {
    var storage = Mimus.Storage()

    private var acceptanceCompletion: (() -> Void)?

    func show(
        title: String,
        message: String?,
        buttonTitle: String,
        acceptanceCompletion: (() -> Void)?
    ) {
        self.acceptanceCompletion = acceptanceCompletion
        recordCall(withIdentifier: "show", arguments: [title, message, buttonTitle])
    }
}

extension FakeInfoAlert {

    func simulateAlertDismissed() {
        acceptanceCompletion?()
    }
}
